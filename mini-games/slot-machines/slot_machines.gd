extends Node2D

var win = false;
var slots = []
var running = false;
var slot_machine_values = [
	{
		"name": "square",
		"icon": load("res://assets/slot-machine/square.png")
	},
	{
		"name": "triangle",
		"icon": load("res://assets/slot-machine/triangle.png")
	},
	{
		"name": "circle",
		"icon": load("res://assets/slot-machine/circle.png")
	}
]
var results = []
var win_function: Callable = func(): pass

func _ready() -> void:
	slots = [
		$slot_1,
		$slot_2,
		$slot_3
	]

func _input(event):
	if event.is_action_pressed("interact") and not running and not win:
		run_machine()
		
func _process(delta: float) -> void:
	if win:
		win_function.call()
func display_result() -> void:
	running = false
	for i in range(slots.size()):
		slots[i].texture = results[i]["icon"]
	return;

func run_machine() -> void:
	running = true
	$running.play()
	await get_tree().create_timer(2.0).timeout
	results = []
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(0, 10)
	
	if !(random_number == 1):
		for i in range(3):
			rng = RandomNumberGenerator.new()
			var random_index = rng.randi_range(0, slot_machine_values.size() - 1)
			results.push_front(slot_machine_values[random_index])
		if results[0] == results[1] and results[1] == results[2]:
			win = true
			$victory.play()
	else:
		win = true
		rng = RandomNumberGenerator.new()
		var random_index = rng.randi_range(0, slot_machine_values.size() - 1)
		for i in range(3):
			results.push_front(slot_machine_values[random_index])
		$victory.play()
	display_result()
	return; 
