class_name EnemyState extends Node

var enemy : Enemy
var state_controller : EnemyStateController
# Called when the node enters the scene tree for the first time.
func Init() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float ) -> EnemyState:
	return null
	
func PhysicProcess( _delta : float ) -> EnemyState:
	return null
