extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var visible_frames = 0
func _process(delta):
	var score = get_tree().root.get_node("Game/Score").score
	$MainPanel/ScoreLabel.text = "[center]Your score is: " + str(score) + "[/center]"
	if visible and not visible_frames == -1:
		visible_frames += 1 
		if visible_frames >= 120:
			#get_tree().root.get_node("Game/Sounds/CoinSound").play()
			$MainPanel.get_node("PlayAgainLabel").visible = true
			visible_frames = -1
			

func _on_visibility_changed():
	if visible:
		get_tree().root.get_node("Game/Sounds/GameOverSound").play()
		
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if $MainPanel.get_node("PlayAgainLabel").visible:
			get_tree().change_scene_to_file("res://scene/reset.tscn")
