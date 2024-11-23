class_name PlayerInteractionController extends Node2D

@onready var player : Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	player.direction_changed.connect( update_direction ) # connect player direction with interact direction
	pass # Replace with function body.


func update_direction(_newDirection : Vector2) -> void:
	match _newDirection: # switch
		Vector2.DOWN:
			rotation_degrees = 0;
		Vector2.UP: 
			rotation_degrees = 180;
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90;
		_: # default
			rotation_degrees = 0;
	pass
