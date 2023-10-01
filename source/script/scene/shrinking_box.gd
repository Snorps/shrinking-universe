extends Node2D


@export var s = 120
var rng = RandomNumberGenerator.new()
var target_pos = Vector2((320/2)-(s/2),(180/2)-(s/2))
var velocity = Vector2(0,0)
var velocity_step = 0.01
var shrink_rate_divisor = 150000
func _process(delta):
	$Patch.size.x = s
	$Patch.size.y = s
	
	shrink_rate_divisor -= 1
	var shrink_rate = pow(s,2)/150000
	s = s - shrink_rate
	position.x = position.x + shrink_rate
	
	$ShapeBottom.position = Vector2(s/2, s - 4)
	$ShapeBottom.get_shape().size.x = s
	$ShapeLeft.position = Vector2(4, s/2)
	$ShapeLeft.get_shape().size.y = s
	$ShapeRight.position = Vector2(s-4, s/2)
	$ShapeRight.get_shape().size.y = s
	$ShapeTop.position = Vector2(s/2,0 + 4)
	$ShapeTop.get_shape().size.x = s
	
	#position = position - (position - target_pos).normalized()
	#velocity.y = -1
	if target_pos.x > position.x:
		velocity.x = velocity.x + velocity_step
	else:
		velocity.x = velocity.x - velocity_step
	if target_pos.y > position.y:
		velocity.y = velocity.y + velocity_step
	else:
		velocity.y = velocity.y - velocity_step
	
	velocity = velocity * 0.95
	position = position + velocity
	
	if abs(position.x - target_pos.x) < 5 and abs(position.y - target_pos.y) < 5:
		#90 used to be s here but the box would crush the player against the corner too much
		var x = rng.randi_range(0,320-90)
		var y = rng.randi_range(0,180-90)
		target_pos = Vector2(x,y)
