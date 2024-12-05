class_name LevelTileMap extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.change_tile_map_bounds( get_tile_map_bounds() )
	pass # Replace with function body.

func get_tile_map_bounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * rendering_quadrant_size ) + position
	)
	bounds.append(
		Vector2( get_used_rect().end * rendering_quadrant_size ) + position
	)
	return bounds 
