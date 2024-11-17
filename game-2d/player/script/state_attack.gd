class_name StateAttack extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var cc : State = $"../Crown Control"

@onready var animationPlayer : AnimationPlayer = $"../../AnimationPlayer" #handle end time of attack animation
@onready var attack_effect : AnimationPlayer = $"../../Sprite2D/AttackEffect/AttackEffect"

var isAttacking : bool = false;
#override all method of state
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_effect.play("attack_" + player.GetDirection())
	animationPlayer.animation_finished.connect( EndAttack )
	isAttacking = true;
	pass
#
func Exit() -> void:
	animationPlayer.animation_finished.disconnect( EndAttack )
	isAttacking = false;
	pass

func Process ( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	
	if isAttacking == false:
		if player.direction != Vector2.ZERO: #if move button is pressing => move else idle.
			return walk
		else: 
			return idle
		
	return  null

func Physic(_delta : float) -> State:
	return null
	
func HanleInputEvent(_event : InputEvent) -> State:
	return null

func EndAttack(nextAnimation : String) -> void:
	isAttacking = false;
