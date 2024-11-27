class_name State extends Node
# parent class for other State class abtract

#store ref to player which state belong to
static var player : Player;
static var state_controller : StateControler
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init() ->  void:
	pass
# define what happen when enter state
func enter() -> void:
	pass
	
func exit() -> void:
	pass

# define what happen when _process update
func process ( _delta : float ) -> State:
	return  null

#
func physic(_delta : float) -> State:
	return null
	
# define what happen when input an event in this state	
func hanle_input_event(_event : InputEvent) -> State:
	return null
