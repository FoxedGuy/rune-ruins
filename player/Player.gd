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

# not const as those are level-dependent
var max_health: int
var max_mana: int
var max_stamina: int

var health: int
var mana: int
var stamina: int

var level: int
var experience_points: int
var experience_to_next_level: int

var effects
var weapon
var inventory

# mainly for GUI
signal health_changed(current_health)
signal mana_changed(current_mana)
signal stamina_changed(current_stamina)
signal leveled_up(current_level)

func _init() -> void:
	#TODO: load from savefile/resource?
	max_health = 100
	max_mana = 50
	max_stamina = 70
	
	health = 100
	mana = 50
	stamina = 70
	
	level = 1
	experience_points = 0
	experience_to_next_level = 100

func _ready() -> void:
	print("Player ready!")

func _input(event: InputEvent) -> void:
	pass

func _process(delta:float) -> void:
	label.text = state_machine.current_state.to_string()

func level_up() -> void:
	level += 1
	experience_points %= experience_to_next_level
	experience_to_next_level *= 2 # this difficulity curve is not ideal
	leveled_up.emit(level)
	
	# TODO: define added values somewhere? Should be correlated to difficulity curve
	max_health += 10
	max_mana += 5
	max_stamina += 5
	
	health = max_health
	health_changed.emit(health_changed)
	mana = max_mana
	mana_changed.emit(mana)
	stamina = max_stamina
	stamina_changed.emit(stamina)

func add_experience_points(exp_points: int) -> void:
	experience_points += exp_points
	if (experience_points >= experience_to_next_level):
		level_up()

func attack() -> void:
	stamina -= 10

func get_damage(damage: int) -> void:
	health -= damage
	health_changed.emit(health)

func get_wall_side() -> PlayerEnums.WallSide:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()

		return PlayerEnums.WallSide.RIGHT if normal.x < 0 else PlayerEnums.WallSide.LEFT
	return PlayerEnums.WallSide.NONE
