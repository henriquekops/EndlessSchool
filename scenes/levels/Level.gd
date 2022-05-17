extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size: Vector2 = get_viewport_rect().size
	
	if(Global.door_name):
		var door_node = find_node(Global.door_name)
		if door_node:
			$Player.global_position = door_node.global_position
			if door_node.global_position.x == 0:
				$Player.global_position.x += 100
			elif door_node.global_position.x > screen_size.x/2:
				$Player.global_position.x -= 100
			elif door_node.global_position.y < screen_size.y/2:
				$Player.global_position.y += 120
			else:
				print("D")
				$Player.global_position.y -= 200
			

				
			
