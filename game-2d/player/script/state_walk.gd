class_name StateWalk extends State

@export var move_speed : float = 100.0

@onready var idle : State = $"../Idle"

#override all method of state
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
#
func Exit() -> void:
	pass

func Process ( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return  null

func Physic(_delta : float) -> State:
	return null
	
func HanleInputEvent(_event : InputEvent) -> State:
	return null
