class_name EnemyStateDied extends EnemyState

@export var animation_name : String = "died"
@export var walk_speed : float = 20.0

@export_category("AI")

@export var after_state : EnemyState 

var direction : Vector2
# Called when the node enters the scene tree for the first time.
func init() -> void:
	pass
	
func enter() -> void:
	enemy.invulnerable = true
	enemy.set_dỉrection( direction )
	enemy.update_animation( animation_name )
	pass
	
func exit() -> void:
	pass
	
func process( _delta : float ) -> EnemyState:
	return null
	
func physics_process( _delta : float ) -> EnemyState:
	return null
