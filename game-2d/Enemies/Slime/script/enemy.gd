class_name Enemy extends CharacterBody2D

signal DirectionChanged( _newDirection : Vector2 )
signal EnemyDamage()

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_STATE = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
var player : Player

#export to set for each type of enemies
@export var invulnerable : bool = false
@export var hp : float = 10

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_controller : EnemyStateController = $EnemyStateController
#@onready var hit_box : HitBox = $HitBox
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_and_slide()
	pass
	
#all method under this is same with player, but _process is diff because it does not be controll by user
func SetDirection() -> bool:
	if direction == Vector2.ZERO: # vector is (0, 0) => do not move
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_STATE.size() ) ) # get new direction and round to int to get the position of direction set
	
	var new_direction = DIR_STATE[direction_id] # get new direction by id in array
	
	if new_direction == cardinal_direction: # if direction not change => not update
		return false;
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 # because use side animation for both left and right so flip it base on y
	return true;
 	
func UpdateAnimation( state : String) -> void:
	animation_player.play(state + "_" + GetDirection());
	pass;
	
func GetDirection() -> String:
	if(cardinal_direction == Vector2.DOWN):
		return "down"
	elif (cardinal_direction == Vector2.UP):
		return "up"
	else:
		return "side"
