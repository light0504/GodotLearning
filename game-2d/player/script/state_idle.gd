class_name StateIdle extends State

@onready var walk : State = $"../Walk"

#override all method of state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
#
func Exit() -> void:
	pass

func Process ( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity = Vector2.ZERO
	return  null

func Physic(_delta : float) -> State:
	return null
	
func HanleInputEvent(_event : InputEvent) -> State:
	return null
