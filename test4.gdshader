shader_type canvas_item;

void fragment() {

vec4 color = texture(TEXTURE, UV);

float time_factor_r = (sin(TIME) + 1.0) * 0.5;
float time_factor_g = (sin(TIME + 2.0) + 1.0) * 0.5;
float time_factor_b = (sin(TIME + 4.0) + 1.0) * 0.5;

color.r = mix(color.r, 1.0, time_factor_r);
color.g = mix(color.g, 1.0, time_factor_g);
color.b = mix(color.b, 1.0, time_factor_b);

COLOR = color;
}
