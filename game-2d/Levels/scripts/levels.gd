class_name Level extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	GlobalPlayerManager.set_as_parent(self)
	GlobalLevelManager.level_load_started.connect( _free_player ) 
	pass 
	
func _free_player() -> void:
	GlobalPlayerManager.un_parent(self)
	queue_free()
