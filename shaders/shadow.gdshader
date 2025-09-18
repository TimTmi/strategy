shader_type canvas_item;


void fragment() {
    // Calculate the distance between the fragment and the light position
    float distance_to_light = length(vec2(0, -32) - SCREEN_UV);

    // Calculate the intensity of the shadow based on the distance to the light
    // Adjust the shadow intensity by modifying the value in the following line
    float shadow_intensity = smoothstep(0.0, 0.2, distance_to_light);

    // Set the color of the fragment to the shadow color with the calculated intensity
    // You can adjust the color and opacity of the shadow by modifying the following line
    vec4 shadow_color = vec4(0.0, 0.0, 0.0, 0.5) * shadow_intensity;

    // Output the final color with the shadow applied
    COLOR = mix(COLOR, shadow_color, shadow_color.a);
}
