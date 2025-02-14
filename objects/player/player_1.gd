extends CharacterBody2D

var SPEED = 300.0
var JUMP_VELOCITY = -1 * Global.jump_strength
var double_jump = 1
@export var camera: Camera2D
@export var camera_follow_speed: float = 5.0 

func _physics_process(delta: float) -> void:
	JUMP_VELOCITY = -1 * Global.jump_strength
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		double_jump = 1
	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or (double_jump < 2 and "double_jump" in Global.p1_power_ups)):
		if !is_on_floor():
			double_jump += 1
		velocity.y = JUMP_VELOCITY

	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if is_on_floor() or "double_jump" in Global.p1_power_ups:
			velocity.x = direction * SPEED
		else:
			velocity.x = direction * SPEED / 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Smooth camera follow
	if camera:
		var camera_speed = 100
		var camera_direction = (global_position - camera.global_position).normalized()
		camera.global_position = camera.global_position.lerp(global_position, camera_follow_speed * delta)
		
	move_and_slide()
