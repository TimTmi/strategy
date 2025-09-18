shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float gray_value = color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722;
	//gray_value *= 2.0;
	COLOR = vec4(gray_value, gray_value, gray_value, gray_value);
}