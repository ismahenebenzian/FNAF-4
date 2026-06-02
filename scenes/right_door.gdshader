shader_type canvas_item;

uniform vec2 light_pos = vec2(0.5, 0.5);
uniform float light_radius = 0.25;
uniform float softness = 0.05;
uniform bool torch_on = false;

void fragment() {
    if (!torch_on) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        float dist = distance(light_pos, UV);
        float alpha = smoothstep(light_radius - softness, light_radius + softness, dist);
        COLOR = vec4(0.0, 0.0, 0.0, alpha);
    }
}