class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hitbox.Damaged.connect( TakeDamage )
	pass # Replace with function body.

func TakeDamage(damage : float) ->  void:
	queue_free()
	pass
