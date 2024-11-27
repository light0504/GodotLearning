class_name StateDash extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"

@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var hurt_box : Area2D = $"../../Sprite2D/HurtBox"

var dash_speed = 500


var is_dash : bool = false
#override all method of state
	
func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect( end_dash )
	is_dash = true
	hurt_box.monitoring = true;
	pass
#
func exit() -> void:
	animation_player.animation_finished.disconnect( end_dash )
	is_dash = false
	hurt_box.monitoring = false;
	pass

func process ( _delta : float ) -> State:
	# Apply dash based on cardinal direction
	if player.cardinal_direction == Vector2.UP:
		player.velocity = Vector2(0, -dash_speed)
	elif player.cardinal_direction == Vector2.DOWN:
		player.velocity = Vector2(0, dash_speed)
	elif player.cardinal_direction == Vector2.LEFT:
		player.velocity = Vector2(-dash_speed, 0)
	elif player.cardinal_direction == Vector2.RIGHT:
		player.velocity = Vector2(dash_speed, 0)

# Auto decrease velocity over time
	player.velocity -= player.velocity * _delta * 5

# Handle animation states
	if not is_dash: 
		if player.direction != Vector2.ZERO: # Movement input detected
			return walk
		else: 
			return idle
	return null

func physic(_delta : float) -> State:
	return null
	
func hanle_input_event(_event : InputEvent) -> State:
	return null

func end_dash(_nextAnimation : String) -> void:
	is_dash = false
