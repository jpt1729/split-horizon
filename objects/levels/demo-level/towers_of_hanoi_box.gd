extends Node2D

signal launch_game
@onready var interaction = $"Interaction-area"

# Called when the node enters the scene tree for the first time.
func play_game():
	emit_signal("launch_game")
	$StaticBody2D.queue_free()
	queue_free()

func _ready():
	interaction.interact = Callable(self, 'play_game')
