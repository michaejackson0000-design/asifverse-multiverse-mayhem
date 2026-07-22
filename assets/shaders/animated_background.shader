shader_type canvas_item;

uniform vec4 base_color : hint_color = vec4(0.04, 0.08, 0.18, 1.0);
uniform float glow_scale : hint_range(0.1, 2.0) = 0.4;

void fragment() {
    vec2 uv = UV;
    vec2 pos = uv * vec2(3.2, 1.5) + vec2(TIME * 0.08, TIME * 0.04);
    float grid = abs(sin(pos.x * 8.0) + cos(pos.y * 8.0)) * 0.02;
    float stars = step(0.994, fract(sin(dot(pos * vec2(12.9898, 78.233), vec2(1.0))) * 43758.5453));
    float circle = pow(1.0 - length(uv - vec2(0.3, 0.4)) * 1.4, 2.0) * 0.25;
    float neon = pow(max(0.0, 0.2 - abs(uv.y - 0.55)) * 3.0, 2.0);
    vec3 color = base_color.rgb + vec3(grid * 0.18 + stars * 0.7 + circle * 0.4 + neon * 0.35);
    COLOR = vec4(color, 1.0);
}
