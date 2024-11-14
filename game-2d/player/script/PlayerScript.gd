class_name Player extends CharacterBody2D

var _base_move_speed : float = 80.0;
var _move_speed : float = _base_move_speed;
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var direction : Vector2 = Vector2.ZERO;
	
	direction.x = Input.get_action_strength("Player-right") - Input.get_action_strength("Player-left");
	direction.y = Input.get_action_strength("Player-down") - Input.get_action_strength("Player-up");
	
	velocity = direction * delta * _move_speed;
	pass
