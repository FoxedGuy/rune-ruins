extends EnemyState

var player: CharacterBody2D

func _enter(previous_state_path: String, data := {}) -> void:
	player = get_tree().get_first_node_in_group("Player")

func update_physics(_delta:float)->void:
	if not player:
		return
	
	var direction = player.global_position - enemy.global_position
	if not enemy.is_on_floor():
		enemy.velocity += enemy.get_gravity() * _delta
	if direction.length() >10:
		var player_is_above = player.global_position.y < enemy.global_position.y - 16
		if (player_is_above or enemy.is_on_wall()) and enemy.is_on_floor():
			finished.emit(self, "Jump", { "return_state": "Aggro" })

		if enemy.is_on_wall() and enemy.is_on_floor():
			enemy.velocity.y = enemy.JUMP_FORCE
	else:
		enemy.velocity.x = 0

	enemy.move_and_slide()
	
	if direction.length() > 10:
		finished.emit(self,"Idle")
