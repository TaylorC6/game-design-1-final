shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float intensity;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex_color = texture(TEXTURE, UV); // Sprite
	vec4 red = vec4(1.0, 0.0, 0.0, 1.0); // in RGBa
	COLOR.rgb = mix(tex_color.rgb, red.rgb, intensity);
	COLOR.a = tex_color.a;
}
//uniform float onoff = 0.0
//
//void fragment() {
	//vec4 color = texture(TEXTURE, UV);
	//color.rgb = mix(color.rgb, vec3(1.0, 0.0, 0.0), 0.5);
	//
	//if (onoff > 0.5){
		//COLOR = color;
		//
	//}
//}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
