extends Control

func _ready() -> void:
	# Trocar o nome da cena principal!
	PlayerSingleton.visible = false
	ScoreSingleton.get_child(0).hide()
	HudSingleton.get_child(0).hide()

func _on_Button_pressed() -> void:
	# Trocar o nome da cena principal!
	PlayerSingleton.visible = true
	ScoreSingleton.get_child(0).show()
	HudSingleton.get_child(0).show()
	MusicController.play_music()
	get_tree().change_scene("res://scenes/School.tscn")


func _on_Instructions_pressed():
	get_tree().change_scene("res://scenes/Instructions.tscn")
