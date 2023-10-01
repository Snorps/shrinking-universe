extends CanvasItem

var score
# Called when the node enters the scene tree for the first time.
func _ready():
	score = get_tree().root.get_node("Game/Score")
	score.swap_palette.connect(on_state_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.

var color_seed = 0
func _process(delta):
	if score.palette > color_seed:
		color_seed = score.palette
		material.set_shader_parameter("seed",color_seed)

func on_state_changed():
	$Sprite.material.set_shader_parameter("seed",5)
