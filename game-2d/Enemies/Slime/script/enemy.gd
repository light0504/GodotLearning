class_name Enemy extends CharacterBody2D

signal direction_changed( _newDirection : Vector2 )
signal enemy_damage( _hurtbox : HurtBox )
signal enemy_destroyed( _hurtbox : HurtBox )

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_STATE = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
var player : Player

#export to set for each type of enemies
@export var invulnerable : bool = false
@export var hp : float = 100

@onready var animation_player : AnimationPlayer = $SlimeAnimation
@onready var sprite : Sprite2D = $SlimeBody
@onready var state_controller : EnemyStateController = $EnemyStateController
@onready var hit_box : HitBox = $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	state_controller.initialize( self )
	player = GlobalPlayerManager.player
	hit_box.damaged.connect( _take_damaged )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	move_and_slide()
	pass
	
#all method under this is same with player, but _process is diff because it does not be controll by user
func set_dỉrection( _new_direction : Vector2 ) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO: # vector is (0, 0) => do not move
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_STATE.size() ) ) # get new direction and round to int to get the position of direction set
	
	var new_direction = DIR_STATE[direction_id] # get new direction by id in array
	
	if new_direction == cardinal_direction: # if direction not change => not update
		return false;
		
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 # because use side animation for both left and right so flip it base on y
	return true;
 	
func update_animation( state : String) -> void:
	animation_player.play(state + "_" + get_direction());
	pass;
	#
func get_direction() -> String:
	if(cardinal_direction == Vector2.DOWN):
		return "down"
	elif (cardinal_direction == Vector2.UP):
		return "up"
	else:
		return "side"

#decrease hp when take dmg
func _take_damaged( _hurtbox : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= _hurtbox.damage
	if hp > 0:
		enemy_damage.emit( _hurtbox )
	else: 
		enemy_destroyed.emit( _hurtbox )
	pass
