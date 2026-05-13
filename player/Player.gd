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

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("move_jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
