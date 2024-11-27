class_name StateControler extends Node

var states : Array [State]
var prev_state : State
var current_state : State 

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_state( current_state.process( delta ) )
	pass

func _physics_process(delta):
	change_state( current_state.physic( delta ))
	pass

func _unhandled_input(event):
	change_state( current_state.hanle_input_event( event ))
	pass

# define array of state
func initialize( _player : Player) -> void:
	states = []
	 
	for c in get_children():
		if  c is State:
			states.append(c)
	if states.size() == 0:
		return
		
	states[0].player = _player
	states[0].state_controller = self
	
	for state in states:
		state.init()
		
	change_state( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT

func change_state (_new_state : State) -> void:
	if _new_state == null || _new_state == current_state:
		return
		
	if current_state:
		current_state.exit()

	prev_state = current_state
	current_state = _new_state;
	current_state.enter()
