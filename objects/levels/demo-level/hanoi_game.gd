extends Node2D

@onready var hanoi = $Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	hanoi.win_function = win_function
	$victory.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func win_function():
	$victory.play()
	await get_tree().create_timer(4).timeout
	queue_free()
