extends Node2D

signal launch_game
@onready var interaction = $"Interaction-area"

# Called when the node enters the scene tree for the first time.
func play_game():
	launch_game.emit()
	queue_free()

func _ready():
	interaction.interact = Callable(self, 'play_game')
