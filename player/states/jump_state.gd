extends PlayerState

var wall_side: PlayerEnums.WallSide

func _enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = player.JUMP_VELOCITY
	wall_side = data['wall_side'] if "wall_side" in data else PlayerEnums.WallSide.NONE
	#player.animation_player.play("jump")

func update_physics(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.SPEED * input_direction_x
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_wall_only():
		var new_wall_side: PlayerEnums.WallSide = player.get_wall_side()
		if wall_side == PlayerEnums.WallSide.NONE:
			finished.emit(ONWALL, {"wall_side": new_wall_side})
		elif wall_side != new_wall_side:
			finished.emit(ONWALL, {"wall_side": new_wall_side})
	if player.velocity.y >= 0:
		if wall_side != PlayerEnums.WallSide.NONE:
			finished.emit(FALLING, {"wall_side": wall_side})
		else: 
			finished.emit(FALLING)
