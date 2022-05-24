extends Node2D

func _ready():
	var screen_size: Vector2 = get_viewport_rect().size
	
	if(Global.door_name):
		var door_node = find_node(Global.door_name)
		if door_node:
			PlayerSingleton.global_position = door_node.global_position
			if door_node.global_position.x == 0:
				print("A")
				PlayerSingleton.global_position.x = 300
				print(PlayerSingleton.global_position)
			elif door_node.global_position.x > screen_size.x/2:
				print("B")
				PlayerSingleton.global_position.x = screen_size.x - 300
				print(PlayerSingleton.global_position)
			elif door_node.global_position.y < screen_size.y/2:
				print("C")
				PlayerSingleton.global_position.y = 200
				print(PlayerSingleton.global_position)
			else:
				print("D")
				PlayerSingleton.global_position.y = screen_size.y - 200
				print(PlayerSingleton.global_position)
				
				
		emit_signal("doorMove")
		

