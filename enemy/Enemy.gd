extends CharacterBody2D
class_name Enemy 

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -300.0

@onready
var sprite = $Sprite2D
@onready
var label = $Label
@onready
var state_machine = $StateMachine

var health: int

func _ready() -> void:
	health = 100

signal health_changed(new_value)

func attack() -> void:
	pass		
func get_damage(damage: int) -> void:
	health -= damage
	health_changed.emit(health)
func _process(delta:float)-> void:
	label.text = state_machine.current_state.to_string()
