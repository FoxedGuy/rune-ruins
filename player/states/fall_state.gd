extends PlayerState

var is_from_wall
var from_wall

func _enter(previous_state_path: String, data := {}) -> void:
	is_from_wall = data['is_from_wall'] if "is_from_wall" in data else false
	from_wall = data['wall'] if is_from_wall else null
	#player.animation_player.play("fall")

func update_physics(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.SPEED * input_direction_x
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_wall_only():
		var wall = "right" if player.get_wall_side() < 0 else "left" 
		
		if not is_from_wall:
			finished.emit(ONWALL, {"wall": wall})
		elif wall != from_wall:
			finished.emit(ONWALL, {"wall": wall})

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
