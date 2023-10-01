extends Node2D


# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var player
var path_follower = preload("res://scene/path_follow_2d.tscn").instantiate()
func _ready():
	$Sprite.play()
	player = get_tree().root.get_node("Game").get_node("Player")
	if player != null:
		player.get_node("BirdPath").add_child(path_follower)
		reset_follower()
		
func reset_follower():
	path_follower.progress_ratio = 0.5 + rng.randf_range(-0.005,0.005)
	

var bird_velocity = Vector2(0,0)
var state = "stalking"
var state_frames = 0
var path_follower_speed = 0
var next_coin_frames = 150
var should_kill_player_next_frame = false
var coin_scene = load("res://scene/coin.tscn")
const path_follower_speed_step = 0.00008
const bird_velocity_step = 0.05
const max_stalk_speed = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	next_coin_frames -= 1
	if next_coin_frames <= 0:
		next_coin_frames = 150
		var coin = coin_scene.instantiate()
		get_tree().root.get_node("Game/Sounds/DropSound").play()
		get_tree().root.get_node("Game").add_child.call_deferred(coin)
		coin.position = position
	state_frames = state_frames - 1
	if state == "dead":
		$Sprite.flip_v = true
		bird_velocity.y += 0.7
		$Sprite.play("default")
		$Sprite.stop()
		if $Killbox != null:
			$KillBox.queue_free()
		if state_frames > 100:
			queue_free()
	elif should_kill_player_next_frame and player != null:
		player.queue_free()
	if state == "stalking":
		if path_follower != null and player != null:
			path_follower_speed += path_follower_speed_step
			path_follower_speed = path_follower_speed * 0.95
			if path_follower.progress_ratio < 0.5:
				path_follower.set_progress_ratio(path_follower.progress_ratio - path_follower_speed)
			else:
				path_follower.set_progress_ratio(path_follower.progress_ratio + path_follower_speed)
			
		
			#var fly_speed = pow((path_follower.global_position - global_position).length(),2)/50000
			var fly_speed = 0.3
			bird_velocity += (path_follower.global_position - global_position).normalized() * fly_speed
	
			if player.position.x > position.x:
				$Sprite.scale.x = -1
			else:
				$Sprite.scale.x = 1
			
			var posdiff = abs(position.x - player.position.x) - abs(position.y - player.position.y)
			if posdiff < 5 and position.y < player.position.y and position.y > 0 and position.x > 0 and position.x <320:
				$Sprite.play("dive")
				state = "preparing"
				state_frames = 50
	if state == "preparing":
		if state_frames <= 0:
			state_frames = 55
			state = "diving"
			get_tree().root.get_node("Game/Sounds/DiveSound").play()
	if state == "diving":
		if $Sprite.scale.x == -1:
			bird_velocity.x = bird_velocity.x + 0.15
		else:
			bird_velocity.x = bird_velocity.x - 0.15
		bird_velocity.y = bird_velocity.y + 0.15
		
		bird_velocity = bird_velocity * 0.95
		
		if state_frames <= 0:
			state = "stalking"
			$Sprite.play("default")
			state_frames = 55
			
		if path_follower != null:
			reset_follower()
	else:
		bird_velocity = bird_velocity * 0.8
	position = position + bird_velocity


func _on_kill_box_area_entered(area):
	if player != null and area == player.get_node("EnemyHitBox"):
		should_kill_player_next_frame = true


func _on_die_box_area_entered(area):
	if player != null and area == player.get_node("EnemyHitBox"):
		if player.velocity.y - bird_velocity.y > 0:
			path_follower.queue_free()
			player.velocity.y -= 200
			get_tree().root.get_node("Game/Sounds/StompSound").play()
			state = "dead"
			state_frames = 100
