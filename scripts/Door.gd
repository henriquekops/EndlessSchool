extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene
	
func _input(event):
	if get_overlapping_bodies().size() > 0:
		if !target_scene:
			print("No scene in this door")
			return
		next_level()
		
func next_level():
	var ERR = get_tree().change_scene(target_scene)
	
	if ERR != OK:
		print("Something failed in the door scene")
		
	Global.door_name = name
