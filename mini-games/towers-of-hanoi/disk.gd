extends Sprite2D

var is_dragging = false #state management
var mouse_offset #center mouse on click
var delay = .1
var drag_finish
var time_elapsed = 0.0
var shake_intensity = 0.1
var shake_speed = 30.0

func _physics_process(delta):
	if is_dragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position()-mouse_offset, delay * delta)
		
		time_elapsed += delta * shake_speed
		self.rotation = sin(time_elapsed) * shake_intensity
	else:
		self.rotation = 0
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				is_dragging = true
				mouse_offset = get_global_mouse_position()-global_position
		else:
			is_dragging = false
			get_parent().drag_finish()
			
			
func victory_animation(delta):
	var tween = get_tree().create_tween()
	
	time_elapsed += delta * shake_speed
	self.rotation = sin(time_elapsed) * shake_intensity
	
	var jump_height = 10  # Adjust for stronger jump
	var original_position = position
	var jump_position = original_position + Vector2(0, -jump_height)
	
	tween.tween_property(self, "position", jump_position, 0.1)  # Quick jump up
	tween.tween_property(self, "position", original_position, 0.2).set_trans(Tween.TRANS_BOUNCE)  # Bounce back
