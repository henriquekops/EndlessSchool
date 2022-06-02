extends Control



func _on_Button_pressed() -> void:
	# Trocar o nome da cena principal!
	PlayerSingleton.visible = true
	HudSingleton.get_child(0).show()
	PlayerSingleton.position.x = 50
	PlayerSingleton.position.y = 50
	get_tree().change_scene("res://scenes/School.tscn")
