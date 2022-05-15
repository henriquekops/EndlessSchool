extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
