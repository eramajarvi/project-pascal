shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float timeScale = 20;
uniform float amplitude = 1000.0f;

void vertex() {

	VERTEX.y += sin(TIME * timeScale + VERTEX.y + VERTEX.x) * amplitude;
}