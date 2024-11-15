class_name State extends Node

#store ref to player which state belong to
static var player : Player;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# define what happen when enter state
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass

# define what happen when _process update
func Process ( _delta : float ) -> State:
	return  null

#
func Physic(_delta : float) -> State:
	return null
	
# define what happen when input an event in this state	
func HanleInputEvent(_event : InputEvent) -> State:
	return null
