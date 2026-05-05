extends Node 
class_name State

signal finished(next_state_path: String, data: Dictionary)

func _enter(previous_state_path: String, data := {}) -> void:
	pass

func _exit() -> void:
	pass
	
func handle_input(_event: InputEvent) -> void:
	pass
	
func update_physics(_delta: float) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
