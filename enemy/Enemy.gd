extends CharacterBody2D
class_name Enemy 

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -300.0

@onready
var sprite = $Sprite2D

var health: int

func _ready() -> void:
	health = 100

signal health_changed(new_value)

func attack() -> void:
	pass		
func get_damage(damage: int) -> void:
	health -= damage
	health_changed.emit(health)
