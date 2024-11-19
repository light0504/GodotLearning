class_name StateAttack extends State

@export var attack_sound : AudioStream #declare the sound.

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var cc : State = $"../Crown Control"

@onready var animationPlayer : AnimationPlayer = $"../../AnimationPlayer" #handle end time of attack animation
@onready var attack_effect : AnimationPlayer = $"../../Sprite2D/AttackEffect/AttackEffect"
@onready var audio_stream : AudioStreamPlayer2D =  $"../../Sound/AudioStreamPlayer2D"
@onready var hurt_box : Area2D = $"../../Sprite2D/HurtBox" # define hurt box set it mornitoring default is false because does not attack
var isAttacking : bool = false;
#override all method of state
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_effect.play("attack_" + player.GetDirection())
	animationPlayer.animation_finished.connect( EndAttack )
	
	audio_stream.stream = attack_sound #get the sound declare
	audio_stream.pitch_scale = 1
	audio_stream.play() # play the sound
	
	isAttacking = true;
	
	get_tree().create_timer(0.1) # wait a little time to start check hit box
	hurt_box.monitoring = true; # make hurt box check is hitting any enemy hit box
	pass
#
func Exit() -> void:
	animationPlayer.animation_finished.disconnect( EndAttack )
	isAttacking = false;
	hurt_box.monitoring = false;
	pass

func Process ( _delta : float ) -> State:
	player.velocity -= player.velocity * _delta * 5 # dash small when both attack and move
	
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
