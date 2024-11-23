class_name StateCC extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"

#override all method of state
func enter() -> void:
	player.update_animation("cc")
	pass
#
func exit() -> void:
	pass

func process ( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity = Vector2.ZERO
	return  null

func physic(_delta : float) -> State:
	return null
	
func hanle_input_event(_event : InputEvent) -> State:
	return null
