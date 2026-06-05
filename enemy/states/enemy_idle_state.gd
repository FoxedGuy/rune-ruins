extends EnemyState

var move_direction : Vector2
var wander_time : float

func rand_wander():
	move_direction = Vector2(randf_range(-1,1), 0).normalized()
	wander_time = randf_range(1,2)

func _enter(previous_state_path: String, data := {}) -> void:
	pass
	rand_wander()	

func update_physics(_delta: float) -> void:

	if not enemy.is_on_floor():
		finished.emit(FALLING)

	if enemy.is_on_wall():
		move_direction.x *= -1
		
	enemy.velocity += enemy.get_gravity() * _delta
	enemy.velocity = move_direction * enemy.SPEED
	wander_time -= _delta

	if wander_time <= 0:
		rand_wander()
	
	enemy.move_and_slide()
		
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 200:
		finished.emit(AGGRO)
	
