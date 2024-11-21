extends Node

var current_tilemaps_bounds : Array[ Vector2 ]
signal TileMapBoundsChanged ( bounds : Array[ Vector2 ] )#connect to tilemap to send tilemap change.

func ChangeTileMapBounds( bounds : Array[ Vector2 ]) -> void:
	current_tilemaps_bounds = bounds
	TileMapBoundsChanged.emit( bounds )
	# setup in Project setting
