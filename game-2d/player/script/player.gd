class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_STATE = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO
# remove base_speed && move_speed because it will be define on state walk

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_controller : StateControler = $StateControler
@onready var hit_box : HitBox = $Hitbox

signal direction_changed( _newDirection : Vector2 )
signal player_damaged( _hurtbox : HurtBox )

var invulrable : bool = false;
@export var hp : float = 10
@export var max_hp : float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalPlayerManager.player = self
	state_controller.initialize(self)
	hit_box.damaged.connect( _take_damaged )
	PlayerGui.update_hp(hp, max_hp)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized() # refactor get direction to move
					# make move dragonized not faster than straight
	pass

func _physics_process(_delta):
	move_and_slide() #if have any move, body will move

func set_direction() -> bool:
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
	
func get_direction() -> String:
	if(cardinal_direction == Vector2.DOWN):
		return "down"
	elif (cardinal_direction == Vector2.UP):
		return "up"
	else:
		return "side"
		
func _take_damaged( _hurtbox : HurtBox ) -> void:
	if invulrable == true:
		return
	update_hp( -_hurtbox.damage )
	
	if hp > 0:
		player_damaged.emit( _hurtbox )
	else:
		print("died")
		player_damaged.emit( _hurtbox )
		update_hp( max_hp )
	
func update_hp( damaged : float ) -> void:
	hp = clampf( hp + damaged, 0, max_hp)
	PlayerGui.update_hp( hp, max_hp)
	
func make_invulable( duration : float ) -> void:
	invulrable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer( duration ).timeout
	
	invulrable = false
	hit_box.monitoring = true
	pass
	
