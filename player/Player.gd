extends CharacterBody2D
class_name Player
@export var SPEED = 400.0
@export var JUMP_VELOCITY = -500.0

@onready
var sprite = $Sprite2D

@onready
var state_machine = $StateMachine

@onready
var label = $Label

var health: int
var mana: int
var stamina: int
var weapon

func _ready() -> void:
	health = 100
	mana = 50
	stamina = 80

signal health_changed(new_value)

func attack() -> void:
	stamina -= 10
	
func get_damage(damage: int) -> void:
	health -= damage
	health_changed.emit(health)

func _input(event: InputEvent) -> void:
	pass
	
func get_wall_side() -> PlayerEnums.WallSide:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()

		return PlayerEnums.WallSide.RIGHT if normal.x < 0 else PlayerEnums.WallSide.LEFT
	return PlayerEnums.WallSide.NONE
	
func _process(delta:float) -> void:
	label.text = state_machine.current_state.to_string()
