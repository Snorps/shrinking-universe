RSRC                     ShaderMaterial            ��������                                                  resource_local_to_scene    resource_name    code    script    shader    shader_parameter/seed        
   local://1          local://ShaderMaterial_gymna �         Shader          @  shader_type canvas_item;

uniform float seed;

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
	vec4 new_color = vec4(1,1,1,1);
	if (seed > 0.f) {
			new_color = vec4(rand(vec2(seed,seed)),rand(vec2(100.0f+seed,100.0f+seed)),rand(vec2(200.0f+seed,200.0f+seed)),1);
	}
	
	int part_to_max = int(floor(rand(vec2(seed,seed)) * 3.f));
	
    if (curr_color == vec4(1,1,1,1)){
        COLOR = new_color;
    }else{
        COLOR = curr_color;
	}
}          ShaderMaterial                             RSRC