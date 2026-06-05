extends PlayerState

func _enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	#player.animation_player.play("idle")

func update_physics(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("move_jump"):
		finished.emit(JUMPING, {"is_from_wall": false})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
