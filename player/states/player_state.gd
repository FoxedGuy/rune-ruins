extends State
class_name PlayerState

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const ONWALL = "OnWall"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "Something went wrong...") 
