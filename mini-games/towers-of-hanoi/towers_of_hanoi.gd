extends Node2D

var win_function: Callable = func(): pass

@onready var disks = [
	{
		"object" : $disk_3, 
		"hitbox" : $disk_3.get_node("hit_box"),
		"value" : 3,
	},
	{
		"object" : $disk_2, 
		"hitbox" : $disk_2.get_node("hit_box"),
		"value" : 2,
	}, 
	{
		"object" : $disk_1, 
		"hitbox" : $disk_1.get_node("hit_box"),
		"value" : 1,
	}, 
]

@onready var towers = [
	{
		"object": $tower_1, 
		"disks": [3, 2, 1]
	}, {
		"object": $tower_2, 
		"disks": []
	}, {
		"object": $tower_3, 
		"disks": []
		}
	]

func _ready() -> void:
	move_towers()

func _process(delta: float) -> void:
	if towers[2]["disks"] == [3,2,1]:
		for disk in disks:
			disk["object"].victory_animation(delta)
		win_function.call()


func move_towers() -> void:
	for tower in towers:
		for i in tower["disks"].size():
			for disk in disks:
				if disk["value"] == tower["disks"][i]:
					var box = tower["object"].get_node("CollisionShape2D")
					var bottom_left_position = box.global_position + Vector2(0, box.shape.get_rect().size.y / 2 - i*12*5)
					disk["object"].global_position = bottom_left_position

func pop_disk(value) -> void:
	for i in towers.size():
		towers[i]["disks"].erase(value)

func is_move_legal(disk, new_tower):
	var current_tower
	for tower in towers:
		if tower["disks"].has(disk.value):
			current_tower = tower			
	if new_tower["disks"].is_empty():
		return true and disk.value == current_tower["disks"][-1]
	else:
		return not (disk.value > new_tower["disks"][-1] or disk.value != current_tower["disks"][-1])

func update_disk_positions() -> void:
	for disk in disks:
		for tower_i in towers.size():
			if towers[tower_i]["object"].get_overlapping_areas().has(disk["hitbox"]):
				if is_move_legal(disk, towers[tower_i]):
					$click_sound.play()
					pop_disk(disk.value)
					towers[tower_i]["disks"].append(disk.value)

func smallest_non_negative(numbers: Array):
	var smallest: float = INF 
	var index: int = -1
	for i in numbers.size():
		if numbers[i] >= 0 and numbers[i] < smallest:
			smallest = numbers[i]
	return smallest if index != -1 else null

func get_intersection_size(area1, area2) -> float:
	# Get the CollisionShape2D nodes from each area.
	var c1 = area1.get_node("CollisionShape2D")
	var c2 = area2.get_node("CollisionShape2D")
	if c1 and c2:
		# Get the shapes from the collision nodes.
		var shape1 = c1.shape
		var shape2 = c2.shape
		print(shape1.get_size())
		print(shape2.get_size())
		# Ensure both shapes are RectangleShape2D.
		if shape1 is RectangleShape2D and shape2 is RectangleShape2D:
			# Use the extents (half the size) to calculate the full size.
			var extents1 = shape1.extents
			var extents2 = shape2.extents
			var size1 = extents1 * 2
			var size2 = extents2 * 2

			# Determine the top-left positions.
			# (Assuming the CollisionShape2D's global_position is its center)
			var pos1 = c1.global_position - extents1
			var pos2 = c2.global_position - extents2

			# Calculate the intersection rectangle.
			var intersect_left   = max(pos1.x, pos2.x)
			var intersect_top    = max(pos1.y, pos2.y)
			var intersect_right  = min(pos1.x + size1.x, pos2.x + size2.x)
			var intersect_bottom = min(pos1.y + size1.y, pos2.y + size2.y)

			if intersect_right > intersect_left and intersect_bottom > intersect_top:
				var intersection_width  = intersect_right - intersect_left
				var intersection_height = intersect_bottom - intersect_top
				return intersection_width * intersection_height           
	return 0.0  # No intersection or invalid shapes.

	
func drag_finish() -> void:
	update_disk_positions()
	move_towers()
