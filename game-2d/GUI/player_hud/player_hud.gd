extends CanvasLayer

var hearts: Array[Heart] = []
var hp_per_heart: float
var is_blank: bool = false

func _ready() -> void:
	for c in $Control/HFlowContainer.get_children():
		if c is Heart:
			hearts.append(c)

func update_hp(_hp: float, _max_hp: float) -> void:
	hp_per_heart = _max_hp / hearts.size()
	var hp: float = _hp
	for i in range(hearts.size()):
		update_heart(i, get_health_value(hp))
		hp -= hp_per_heart

func update_heart(i: int, value: int) -> void:
	if i < hearts.size():  # Ensure the index is valid
		hearts[i].frame = value

func get_health_value(hp: float) -> int:
	if hp >= hp_per_heart:
		return 2
	elif hp > hp_per_heart / 2:
		return 1
	return 0
