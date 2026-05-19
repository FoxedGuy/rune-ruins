extends EnemyState

var return_state : String

func _enter(previous_state_path: String, data := {}) -> void:
	return_state = data.get("return_state", "Aggro")
	enemy.velocity.y = enemy.JUMP_VELOCITY

func update_physics(_delta: float) -> void:
	if not enemy:
		return
	enemy.velocity += enemy.get_gravity() * _delta
	enemy.move_and_slide()
	
	if enemy.velocity.y > 0:
		finished.emit(self,"Fall",{"return_state":return_state})
