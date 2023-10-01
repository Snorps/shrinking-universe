extends RigidBody2D

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
var out_frames = 0
func _process(delta):
	if $CrushBox.get_overlapping_bodies() != []:
		out_frames = out_frames + 1
		if out_frames > 6:
			queue_free()


func _on_hit_box_area_entered(area):
	if area.get_owner().get_class() == "CharacterBody2D":
		get_tree().root.get_node("Game").get_node("Shrinking Box").s += 10
		get_tree().root.get_node("Game/Sounds/PickupSound").play()
		queue_free()
		
