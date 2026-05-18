extends EnemyState

var player: CharacterBody2D

func _enter(previous_state_path: String, data := {}) -> void:
	player = get_tree().get_first_node_in_group("Player")

func update_physics(_delta:float)->void:
	var direction = player.global_position - enemy.global_position
	if direction.length() >10:
		enemy.velocity = direction.normalized() * enemy.SPEED
	else: 
		enemy.velocity = Vector2()
	
	if direction.length() >10:
		finished.emit(IDLE)
