extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return;
	Global.add_p1_power_up("double_jump")
	Global.jump_strength = 600
	queue_free();
