extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene

var load_timer
var timer
var ERR

func _ready():
	load_timer = get_tree().create_timer(0.0)

	
func wait_for_attack():
	if load_timer.time_left <= 0.0 && get_overlapping_bodies().size() > 0:
		load_timer = get_tree().create_timer(0.1)
		yield(load_timer, "timeout")
		next_level()

	
func _input(event):
	
	if get_overlapping_bodies().size() > 0:
		if !target_scene:
			print("No scene in this door")
			return
		wait_for_attack()
		
		
		
func next_level():
	if get_overlapping_bodies().size() > 0:
		ERR = get_tree().change_scene(target_scene)
		if ERR != OK:
			print("Something failed in the door scene")
		Global.door_name = name
	# Disable shooting until timer's timeout complete


