class_name EnemyStateIdle extends EnemyState

@export var animation_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5 # export time want to set to ai controll enemy state
@export var state_duration_max : float = 1.5

@export var after_state : EnemyState 

var _timer : float = 0
# Called when the node enters the scene tree for the first time.
func init() -> void:
	pass
	
func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range( state_duration_min, state_duration_max )
	enemy.update_animation( animation_name )
	pass
	
func exit() -> void:
	pass
	
func process(_delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_state
	return null
	
func physics_process( _delta : float ) -> EnemyState:
	return null