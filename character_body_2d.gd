extends CharacterBody2D
const SPEED = 400.0
const JUMP_VELOCITY = -400.0

@onready
var sprite = $Sprite2D

# TODO: should be changed along the way
var health = 100
var mana = 30
var stamina = 50
var is_attacking: bool = false
var weapon 

func attack() -> void:
	is_attacking = true
	stamina -= 10
	is_attacking = false
	
func get_damage(damage: int) -> void:
	health -= damage

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
