class_name EnemyStateStun extends EnemyState

@export var animation_name : String = "stun"
@export var walk_speed : float = 20.0

@export_category("AI")

@export var after_state : EnemyState 
@export var knockback_spd : float = 150
@export var decelerate : float = 20

var direction : Vector2
var animation_finished : bool = false
# Called when the node enters the scene tree for the first time.
func init() -> void:
	enemy.enemy_damage.connect( _on_enemy_damaged )
	pass
	
func enter() -> void:
	animation_finished = false
	enemy.invulnerable = true
	direction = enemy.global_position.direction_to( enemy.player.global_position )
	enemy.set_dỉrection( direction )
	enemy.update_animation( animation_name )
	enemy.velocity = direction * -knockback_spd
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass
	
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass
	
func process( _delta : float ) -> EnemyState:
	if enemy.hp <= 0:
		return $"../Died"
	if animation_finished == true:
		return after_state
	enemy.velocity -= enemy.velocity * decelerate * _delta
	return null
	
func physics_process( _delta : float ) -> EnemyState:
	return null
	
func _on_enemy_damaged() -> void:
	state_controller.change_state( self )

func _on_animation_finished( _a : String) -> void:
	animation_finished = true
