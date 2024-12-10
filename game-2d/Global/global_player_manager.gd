extends Node

const PLAYER  = preload("res://player/player.tscn")

var player : Player
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance() 
	await get_tree().create_timer(1.0).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate() #start the player node
	add_child( player )
	pass

func set_player_position(position : Vector2) -> void:
	player.global_position = position
	
func set_as_parent( _p : Node2D) -> void: # ADD PLAYER TO A NODE
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )
	
func un_parent( _p : Node2D) -> void: # remove player 
	_p.remove_child( player )
