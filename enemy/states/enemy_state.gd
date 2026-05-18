extends State
class_name EnemyState

const IDLE = "Idle"
const AGGRO = "Aggro"
const FALLING = "Falling"
const JUMPING = "Jumping"

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "Something went wrong...") 
