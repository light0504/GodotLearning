class_name EnemyStateWander extends EnemyState

@export var animation_name : String = "move"
@export var walk_speed : float = 20.0

@export_category("AI")
@export var state_duration : float = 0.9 # export time want to set to ai controll enemy state
@export var cycles_min : int = 1
@export var cycles_max : int = 4

@export var after_state : EnemyState 

var _timer : float = 0
var direction : Vector2
# Called when the node enters the scene tree for the first time.
func init() -> void:
	pass
	
func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randi_range( cycles_min, cycles_max ) * state_duration
	var rand = randi_range( 0, 3)
	direction = enemy.DIR_STATE[rand]
	enemy.set_dỉrection( direction )
	enemy.update_animation( animation_name )
	enemy.velocity = direction * walk_speed
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
