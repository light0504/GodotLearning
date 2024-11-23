extends Node

var current_tilemaps_bounds : Array[ Vector2 ]
signal tile_map_bounds_changed ( bounds : Array[ Vector2 ] )#connect to tilemap to send tilemap change.

func change_tile_map_bounds( bounds : Array[ Vector2 ]) -> void:
	current_tilemaps_bounds = bounds
	tile_map_bounds_changed.emit( bounds )
	# setup in Project setting
