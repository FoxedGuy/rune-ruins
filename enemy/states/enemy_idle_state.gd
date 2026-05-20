extends EnemyState

var move_direction : Vector2
var wander_time : float

func rand_wander():
	move_direction = Vector2(randf_range(-2,2), 0).normalized()
	wander_time = randf_range(1,3)

func _enter(previous_state_path: String, data := {}) -> void:
	pass
	#rand_wander()	

func update_physics(_delta: float) -> void:

	if not enemy.is_on_floor():
		finished.emit(FALLING)

	if enemy.is_on_wall():
		move_direction.x *= -1
		
	enemy.velocity += enemy.get_gravity() * _delta
	enemy.velocity = move_direction * enemy.SPEED
	
	
	enemy.move_and_slide()
		
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 200:
		finished.emit(AGGRO)
	
