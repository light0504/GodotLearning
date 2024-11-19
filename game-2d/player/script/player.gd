class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_STATE = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
# remove base_speed && move_speed because it will be define on state walk


@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var sprite : Sprite2D = $Sprite2D
@onready var state_controller : StateControler = $StateControler


signal DirectionChanged( _newDirection : Vector2 )

# Called when the node enters the scene tree for the first time.
func _ready():
	state_controller.Initialize(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized() # refactor get direction to move
					# make move dragonized not faster than straight
	pass

@warning_ignore("unused_parameter")
func _physics_process(delta):
	move_and_slide()

func SetDirection() -> bool:
	#var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO: # vector is (0, 0) => do not move
		return false
	#if direction.y == 0:
		#new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT # y not change => x < 0 is move left else move right
	#elif direction.x == 0:
		#new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN # x not change => y > 0 is move up else move down
	#
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_STATE.size() ) ) # get new direction and round to int to get the position of direction set
	
	var new_direction = DIR_STATE[direction_id]
	
	if new_direction == cardinal_direction: # if direction not change => not update
		return false;
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 # because use side animation for both left and right so flip it base on y
	return true;
#	
	# remove SetState() because it will be define in state controller
	
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
