// Simple box blur shader for Niri
// Based on official examples

vec4 window_shader() {
    vec2 size = vec2(textureSize(niri_tex, 0));
    vec2 step = 2.0 / size; // Adjust for blur strength
    
    vec4 color = texture(niri_tex, niri_texcoord);
    color += texture(niri_tex, niri_texcoord + vec2(step.x, 0.0));
    color += texture(niri_tex, niri_texcoord + vec2(-step.x, 0.0));
    color += texture(niri_tex, niri_texcoord + vec2(0.0, step.y));
    color += texture(niri_tex, niri_texcoord + vec2(0.0, -step.y));
    
    return color / 5.0;
}
