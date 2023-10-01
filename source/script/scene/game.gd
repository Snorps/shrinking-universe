extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var bird_scene = load("res://scene/bird.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
var new_bird_frames = 500
var rng = RandomNumberGenerator.new()
func _process(delta):
	new_bird_frames = new_bird_frames - 1
	if new_bird_frames <= 0:
		new_bird_frames = 300
		var bird = bird_scene.instantiate()
		add_child(bird)
		var pos = Vector2(-27 + round(rng.randf())*374, 60)
		bird.position = pos
		print(pos)
		
