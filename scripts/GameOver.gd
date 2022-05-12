extends Control



func _on_Button_pressed() -> void:
	# Trocar o nome da cena principal!
	get_tree().change_scene("res://Scenes/School.tscn")
