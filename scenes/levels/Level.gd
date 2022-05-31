extends Node2D

func _ready():
	var screen_size: Vector2 = get_viewport_rect().size
	
	if(Global.door_name):
		var door_node = find_node(Global.door_name)
		if door_node:
			PlayerSingleton.global_position = door_node.global_position
			if door_node.global_position.x == 0:
				PlayerSingleton.global_position.x = 300
			elif door_node.global_position.x > screen_size.x/2:
				PlayerSingleton.global_position.x = screen_size.x - 300
			elif door_node.global_position.y < screen_size.y/2:
				PlayerSingleton.global_position.y = 200
			else:
				PlayerSingleton.global_position.y = screen_size.y - 200
		

