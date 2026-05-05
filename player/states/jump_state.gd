extends PlayerState

func _enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = player.JUMP_VELOCITY
	#player.animation_player.play("jump")

func update_physics(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.SPEED * input_direction_x
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()

	if player.velocity.y >= 0:
		finished.emit(FALLING)
