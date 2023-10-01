extends RichTextLabel



signal swap_palette
var palette = 0
var start_time = Time.get_ticks_msec()
func _ready():
	pass 


@export var player: CharacterBody2D
var score = 0
var dead = false
var game_over_frames = 0
const frames_between_palette_swap = 300 #300
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		score = (Time.get_ticks_msec() - start_time)/100
		text = str(score)
	elif dead == false:
		get_tree().root.get_node("Game/Sounds/StompSound").play()
		dead = true
	if dead == true:
		game_over_frames += 1 
		if game_over_frames >= 60:
			get_tree().root.get_node("Game/GameOverScreen").visible = true
			
	if palette < floor(score/frames_between_palette_swap):
		palette = floor(score/frames_between_palette_swap)
		emit_signal("palette_swap")
		material.set_shader_parameter("seed",palette)
