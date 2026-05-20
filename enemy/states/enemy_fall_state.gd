extends EnemyState

func _enter(previous_state_path: String, data := {}) -> void:
	pass
func update_physics(delta: float) -> void:
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()
	if enemy.is_on_floor():
		finished.emit(IDLE)
