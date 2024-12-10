@tool
class_name LevelTransition extends Area2D

enum SIDE{TOP, RIGHT, BOTTOM, LEFT}

@export_file("*.tscn") var level # DROP THE SCENCE WILL TELEPORT TO THIS
@export var target_transition_area : String = "LevelTransition"

@export_category("Collision Area Settings")

@export_range( 1, 12, 1, "or_greater") var size : int = 2 :
	set( _v ):
		size = _v
		_update_area()

@export var side : SIDE = SIDE.LEFT

@export var snap_to_grid : bool = false: #make gate fit chunk
	set( _s ):
		snap_to_grid = _s
		_snap_to_grid()
		

@onready var collision_shape : CollisionShape2D = $LevelEntrance

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await GlobalLevelManager.level_loaded
	
	monitoring = true
	
	
	body_entered.connect( _player_entered )
	pass # Replace with function body.

func _player_entered( _p : Node2D ) -> void:
	GlobalLevelManager.load_new_level( level, target_transition_area, get_offset())
	pass
	
func _place_player() -> void:
	if name != GlobalLevelManager.target_transition:
		return
	GlobalPlayerManager.set_player_position( global_position + GlobalLevelManager.position_offset )
	
func get_offset() ->  Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = GlobalPlayerManager.player.global_position
	
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = 16
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		offset.x = player_pos.x - global_position.x
		offset.y = 16
		if side == SIDE.TOP:
			offset.y *= -1
	
	return offset
func _update_area() -> void:
	var new_rect : Vector2 = Vector2(32, 32)
	var new_pos : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_rect.x *= size
		new_pos.y -= 16 
	elif side == SIDE.BOTTOM:
		new_rect.x *= size
		new_pos.y += 16 
	elif side == SIDE.LEFT:
		new_rect.y *= size
		new_pos.x -= 16 
	elif side == SIDE.RIGHT:
		new_rect.y *= size
		new_pos.x += 16 
		
	if collision_shape == null:
		collision_shape = get_node("LevelEntrance")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_pos

func _snap_to_grid() -> void:
	position.x = roundi(position.x / 16) * 16
	position.y = roundi(position.y / 16) * 16
