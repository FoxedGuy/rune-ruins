extends EnemyState
var return_state : String
func _enter(previous_state_path: String, data := {}) -> void:
	return_state = data.get("return_state","Aggro")

func update_physics(delta: float) -> void:
	if not enemy:
		return
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()
	if enemy.is_on_floor():
		finished.emit(self,return_state)
