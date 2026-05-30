extends State
class_name EnemyState

const IDLE = "Idle"
const AGGRO = "Aggro"
const FALLING = "Falling"
const JUMPING = "Jumping"

var enemy: Enemy
var player: Player

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	player = get_tree().get_first_node_in_group("Player")
	assert(player != null,"Player needs to exist")
	assert(enemy != null, "Something went wrong...") 
