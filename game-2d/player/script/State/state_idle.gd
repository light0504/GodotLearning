class_name StateIdle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"
@onready var cc : State = $"../Stun"
@onready var dash : State = $"../Dash"

#override all method of state
	
func enter() -> void:
	player.update_animation("idle")
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
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("dash"):
		return dash
	return null
