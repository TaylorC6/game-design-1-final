shader_type canvas_item;

void fragment() {

vec4 color = texture(TEXTURE, UV);
vec3 gradient_color = mix(vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 1.0), UV.y);
color.rgb = mix(color.rgb, gradient_color, 0.5);
COLOR = color;
}