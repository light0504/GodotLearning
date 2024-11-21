class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.TileMapBoundsChanged.connect( UpdateCameraLimits )
	UpdateCameraLimits( GlobalLevelManager.current_tilemaps_bounds )
	pass # Replace with function body.

func UpdateCameraLimits( bounds : Array[ Vector2 ]) -> void:
	print(bounds)
	if bounds == []:
		return
	limit_left = int ( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int ( bounds[1].x )
	limit_bottom = int ( bounds[1].y )
	pass # pass an vector render of map automation to camera scripts and get this to set limit of camera notget out of map.
# create a folder Global to load all component of map like camera
