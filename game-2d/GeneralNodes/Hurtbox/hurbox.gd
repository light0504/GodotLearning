class_name HurtBox extends Area2D

# watch that is it touch any enemy hit box and send damage of attacker to this
# Called when the node enters the scene tree for the first time.

@export var damage : float = 10;
func _ready():
	area_entered.connect(AreaEntered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func AreaEntered ( a: Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(damage)
	pass
