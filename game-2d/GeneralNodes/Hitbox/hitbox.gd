class_name HitBox extends Area2D

#Hit box mornitoring off => Cannot watch is it touch other areas, but able to other area check will it touch this  
signal damaged (damage : float)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func take_damage (damage : float) -> void:
	damaged.emit( damage )
	pass
