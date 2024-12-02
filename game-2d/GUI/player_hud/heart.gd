class_name Heart extends Control

@onready var sprite : Sprite2D = $Sprite2D

var frame : int = 2: 
	set( _frame ):
		frame = _frame
		update_sprite()
		
func update_sprite() -> void:
	sprite.frame = frame
