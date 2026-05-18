extends EnemyState

var move_direction : Vector2
var wander_time : float
var player : CharacterBody2D

func rand_wander():
	move_direction = Vector2(randf_range(-2,2), 0).normalized()
	wander_time = randf_range(1,3)

func _enter(previous_state_path: String, data := {}) -> void:
	player = get_tree().get_first_node_in_group("Player")
	rand_wander()	
func Update(delta:float):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_wander()
		
func update_physics(_delta: float) -> void:
	if enemy:
		enemy.velocity = move_direction * enemy.SPEED
		
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 20:
		finished.emit(self,"Aggro")
	
