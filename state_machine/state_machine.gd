extends Node
class_name StateMachine

@export var initial_state: State = null

@onready
var current_state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)).call()

func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := current_state.name
	current_state._exit()
	current_state = get_node(target_state_path)
	current_state._enter(previous_state_path, data)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
			
	await owner.ready
	current_state._enter("")

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)
