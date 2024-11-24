class_name PlayerCamera extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.tile_map_bounds_changed.connect( update_camera_limits )
	update_camera_limits( GlobalLevelManager.current_tilemaps_bounds )
	pass # Replace with function body.

func update_camera_limits( bounds : Array[ Vector2 ]) -> void:
	if bounds == []:
		return
	limit_left = int ( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int ( bounds[1].x )
	limit_bottom = int ( bounds[1].y )
	pass # pass an vector render of map automation to camera scripts and get this to set limit of camera notget out of map.
# create a folder Global to load all component of map like camera
