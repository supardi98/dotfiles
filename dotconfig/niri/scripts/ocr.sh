#!/usr/bin/env bash
# 🔤 Screen OCR Tool (Super + Shift + O)
# Grabs a region, extracts text via Tesseract OCR, and copies to clipboard

if ! command -v tesseract &>/dev/null; then
    notify-send -u critical -i dialog-error "OCR Tool" "Tesseract belum terinstall. Silakan install: sudo pacman -S tesseract tesseract-data-eng"
    exit 1
fi

TMP_IMG="/tmp/ocr_capture.png"
TMP_TXT="/tmp/ocr_result"

# Select region and screenshot
if ! grim -g "$(slurp)" "$TMP_IMG" 2>/dev/null; then
    # User cancelled selection
    exit 0
fi

if [ ! -s "$TMP_IMG" ]; then
    exit 0
fi

# Run OCR (using English and Indonesian if available)
LANGS="eng"
if tesseract --list-langs | grep -q "ind"; then
    LANGS="eng+ind"
fi

tesseract "$TMP_IMG" "$TMP_TXT" -l "$LANGS" quiet 2>/dev/null

RESULT_FILE="${TMP_TXT}.txt"

if [ -f "$RESULT_FILE" ]; then
    CLEANED_TEXT=$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' "$RESULT_FILE")
    
    if [ -n "$CLEANED_TEXT" ]; then
        echo -n "$CLEANED_TEXT" | wl-copy
        # Truncate preview for notification
        PREVIEW=$(echo "$CLEANED_TEXT" | head -n 3 | cut -c 1-80)
        notify-send -u normal -i edit-copy -t 3500 "OCR Text Copied! 📋" "$PREVIEW"
    else
        notify-send -u low -i dialog-information -t 2000 "OCR Tool" "Tidak ada teks yang terdeteksi pada area yang dipilih."
    fi
    rm -f "$RESULT_FILE"
fi

rm -f "$TMP_IMG"
