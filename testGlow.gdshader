shader_type canvas_item;

void fragment() {

vec4 color = texture(TEXTURE, UV);

float time_factor_rgb = (sin(TIME) + 3.0) * 0.1;
color.rgb = mix(color.rgb, vec3(1.0, 1.0, 1.0), time_factor_rgb);
COLOR = color;
}
