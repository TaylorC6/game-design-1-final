shader_type canvas_item;

void fragment() {

vec4 color = texture(TEXTURE, UV);
color.rgb = mix(color.rgb, vec3(1.0, 0.0, 0.0), 0.5);
COLOR = color;
}