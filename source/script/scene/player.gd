extends CharacterBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
var jumping_frames = 0
var play_running_anim = false
var jump_factor = 1.1
func _process(delta):
	if jumping_frames > 0:
		jumping_frames = jumping_frames - 1
	if Input.is_action_pressed("char_jump"):
		if is_on_floor():
			jumping_frames = 5
			get_tree().root.get_node("Game/Sounds/JumpSound").play()
			velocity.y = (velocity.y - 90 - abs(velocity.x/8)) * jump_factor
		if jumping_frames > 0:
			velocity.y = (velocity.y - 10) * jump_factor
	play_running_anim = false
	if Input.is_action_pressed("char_left"):
		velocity.x = velocity.x - 18
		$Sprite.flip_h = true
		$Sprite.play("run")
		play_running_anim = true
	if Input.is_action_pressed("char_right"):
		velocity.x = velocity.x + 18
		$Sprite.flip_h = false
		$Sprite.play("run")
		play_running_anim = true
	if not play_running_anim:
		$Sprite.play("stand")

	velocity.y = velocity.y + 8
	velocity.x = velocity.x * 0.85
	
	move_and_slide()

func _on_area_body_entered(body):
	queue_free()
		
