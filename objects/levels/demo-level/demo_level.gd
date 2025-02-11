extends Node2D

var minigame_scene

func _ready():
	$"Towers-of-hanoi-box".launch_game.connect(play_towers_of_hanoi)

func close_towers_of_hanoi():
	if minigame_scene and is_instance_valid(minigame_scene):
		minigame_scene.queue_free() 
		
func play_towers_of_hanoi():
	minigame_scene = load("res://objects/levels/demo-level/hanoi-game.tscn").instantiate()
	get_tree().current_scene.add_child(minigame_scene)
