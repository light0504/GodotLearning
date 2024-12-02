class_name EnemyStateDied extends EnemyState

@export var animation_name : String = "died"
@export var walk_speed : float = 20.0

@export_category("AI")

@export var knockback_spd : float = 200
@export var after_state : EnemyState 
@export var decelerate : float = 10

var animation_finished : bool = false

var direction : Vector2
var damaged_position : Vector2
# Called when the node enters the scene tree for the first time.
func init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )
	pass
	
func enter() -> void:
	enemy.invulnerable = true
	direction = enemy.global_position.direction_to( damaged_position )
	enemy.set_dỉrection( direction )
	enemy.velocity = direction * -knockback_spd
	enemy.update_animation( animation_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass
	
func exit() -> void:
	pass
	
func process( _delta : float ) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate * _delta
	return null
	
func physics_process( _delta : float ) -> EnemyState:
	return null

func _on_enemy_destroyed(_hurtbox : HurtBox ) -> void:
	damaged_position = _hurtbox.global_position
	state_controller.change_state( self )
	pass
	
func _on_animation_finished( _a : String) -> void:
	animation_finished = true
	enemy.queue_free()
