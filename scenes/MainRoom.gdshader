shader_type canvas_item;

uniform vec2 light_pos = vec2(1, 1);

// Taille du cercle
uniform float radius =0.5;

// Douceur du halo
uniform float softness = 0.18;

// Obscurité générale
uniform float darkness = 1;

void fragment() {

    float dist = distance(UV, light_pos);

    // Halo très doux
    float light = smoothstep(radius + softness, radius, dist);

    // Centre plus lumineux
    light = pow(light, 1.8);

    // Alpha final
    float alpha = darkness - light;

    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}