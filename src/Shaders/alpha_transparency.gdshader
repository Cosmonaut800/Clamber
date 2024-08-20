shader_type canvas_item;

uniform float userAlpha;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR = COLOR*vec4(1.0f, 1.0f, 1.0f, userAlpha);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
