class_name StateWalk extends State

@export var move_speed : float = 150.0

@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"
@onready var cc : State = $"../Stun"
@onready var dash : State = $"../Dash"

#override all method of state
	
func enter() -> void:
	player.update_animation("walk")
	pass
#
func exit() -> void:
	pass

func process ( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	
	return  null

func physic(_delta : float) -> State:
	return null
	
func hanle_input_event(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("dash"):
		return dash
	return null
