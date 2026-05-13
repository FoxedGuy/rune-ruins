extends PlayerState

const INPUT_BUFFER_TIME := 0.13

var direction_buffer_timer := 0.0
var buffered_direction_x := 0.0

var wall_side: PlayerEnums.WallSide

func _enter(previous_state_path: String, data := {"wall_side": PlayerEnums.WallSide}) -> void:
	player.velocity.y = 0 # not sure if smart 
	wall_side = data['wall_side']
	
func update_physics(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	if not is_equal_approx(input_direction_x, 0.0):
		buffered_direction_x = input_direction_x
		direction_buffer_timer = INPUT_BUFFER_TIME
	else:
		direction_buffer_timer -= delta

	var used_direction_x := input_direction_x
	if is_equal_approx(used_direction_x, 0.0) and direction_buffer_timer > 0.0:
		used_direction_x = buffered_direction_x

	player.velocity.x = player.SPEED * used_direction_x
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	if Input.is_action_just_pressed("move_jump"):
		finished.emit(JUMPING, {"wall_side": wall_side})
	if not player.is_on_wall() and direction_buffer_timer < 0:
		finished.emit(FALLING, {"wall_side": wall_side})
	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
