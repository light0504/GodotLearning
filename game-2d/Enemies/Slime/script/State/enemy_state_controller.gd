class_name EnemyStateController extends Node

var states : Array [EnemyState]
var prev_state : EnemyState
var current_state : EnemyState 

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED #do not read any data, disable until init it
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Initialize( _enemy : Enemy) -> void:
	states = []
	 
	for c in get_children():
		if  c is EnemyState:
			states.append(c)
		
	for s in states:
		s.enemy = _enemy;
		s.state_controller = self
		s.Init()
			
	if states.size() > 0:
		ChangeState( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
		
func ChangeState (_new_state : EnemyState) -> void:
	if _new_state == null || _new_state == current_state:
		return
		
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = _new_state;
	current_state.Enter()