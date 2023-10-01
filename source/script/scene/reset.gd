extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var wait_frames = 20
func _process(delta):
	wait_frames -= 1
	if wait_frames <= 0:
		get_tree().change_scene_to_file("res://scene/game.tscn")
