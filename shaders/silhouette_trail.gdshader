shader_type canvas_item;

uniform float mix_color;
uniform vec4 material_color: source_color;

void vertex() {
	
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (texture_color.a != 0.0)
		COLOR = vec4(mix(texture_color.rgb, material_color.rgb, mix_color), material_color.a);
}

void light() {
	float cNdotL = max(1.0, dot(NORMAL, LIGHT_DIRECTION));
	LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY * cNdotL, LIGHT_COLOR.a);
}
