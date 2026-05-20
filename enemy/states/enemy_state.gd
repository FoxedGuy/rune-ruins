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
	player = enemy.get_parent().get_node("Player")
	assert(player != null,"Player needs to exist")
	assert(enemy != null, "Something went wrong...") 
