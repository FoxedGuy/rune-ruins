extends EnemyState


func _enter(previous_state_path: String, data := {}) -> void:
	print("player spotted")

func update_physics(_delta:float)->void:
	var direction = player.global_position - enemy.global_position
	if not enemy.is_on_floor():
		enemy.velocity += enemy.get_gravity() * _delta
	if direction.length() >10:
		enemy.velocity = direction.normalized() * enemy.SPEED
		var player_is_above = player.global_position.y < enemy.global_position.y - 16
		if (player_is_above or enemy.is_on_wall()) and enemy.is_on_floor():
			finished.emit(JUMPING)

		if enemy.is_on_wall() and enemy.is_on_floor():
			enemy.velocity.y = enemy.JUMP_FORCE
	else:
		enemy.velocity.x = 0

	enemy.move_and_slide()
	
	
