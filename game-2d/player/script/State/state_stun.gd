class_name StateStun extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"

@onready var hurtbox : HurtBox

@export var stun_time : float = 0.4

var animation_finished : bool = false
var direction : Vector2
var invulnerable_direction : float = 1
var knockback_spd : float = 250.0
var decelerate : float = 100.0

var next_state : State = null
#override all method of state

func init() -> void:
	player.player_damaged.connect( _player_damaged )

func enter() -> void:
	player.update_animation("stun")
	player.animation_player.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurtbox.global_position )
	player.velocity = direction * -knockback_spd
	player.set_direction()
	
	player.make_invulable( invulnerable_direction )
	
	pass
#
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass

func process ( _delta : float ) -> State:
	stun_time -= _delta
	player.velocity -= player.velocity * decelerate * _delta
	return next_state

func physic(_delta : float) -> State:
	return null
	
func hanle_input_event(_event : InputEvent) -> State:
	return null

func _player_damaged( _hurtbox : HurtBox) -> void:
	hurtbox = _hurtbox
	state_controller.change_state( self )
	
func _animation_finished( _next_ani : String) -> void:
	animation_finished = true
	next_state = idle
	
