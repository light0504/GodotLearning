extends Node

signal level_load_started
signal level_loaded

var target_transition : String
var position_offset : Vector2

var current_tilemaps_bounds : Array[ Vector2 ]
signal tile_map_bounds_changed ( bounds : Array[ Vector2 ] )#connect to tilemap to send tilemap change.

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()
	pass
func change_tile_map_bounds( bounds : Array[ Vector2 ]) -> void:
	current_tilemaps_bounds = bounds
	tile_map_bounds_changed.emit( bounds )
	# setup in Project setting

func load_new_level(
	level_path : String,
	_target_transition : String,
	_position_offset : Vector2
) -> void:
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await get_tree().process_frame #Level transition
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( level_path )
	
	await get_tree().process_frame #Level transition
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	pass
