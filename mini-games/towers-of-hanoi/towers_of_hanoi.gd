extends Node2D

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
		print('Victory!')


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
		return true
	else:
		return not (disk.value > new_tower["disks"][-1] or disk.value != current_tower["disks"][-1])

func update_disk_positions() -> void:
	for disk in disks:
		for tower_i in towers.size():
			if towers[tower_i]["object"].get_overlapping_areas().has(disk["hitbox"]):
				if is_move_legal(disk, towers[tower_i]):
					pop_disk(disk.value)
					towers[tower_i]["disks"].append(disk.value)

func drag_finish() -> void:
	update_disk_positions()
	move_towers()
