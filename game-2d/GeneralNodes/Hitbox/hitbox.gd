class_name HitBox extends Area2D

#Hit box mornitoring off => Cannot watch is it touch other areas, but able to other area check will it touch this  
signal damaged ( _hurtbox : HitBox )
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func take_damage ( _hurtbox : HurtBox ) -> void:
	damaged.emit( _hurtbox )
	pass
