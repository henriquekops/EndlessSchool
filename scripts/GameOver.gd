extends Control

onready var finalScore := $CenterContainer/VBoxContainer/FinalScore

func _ready() -> void:
	finalScore.text = "YOUR FINAL SCORE WAS: " + str(Global.score)

func _on_Button_pressed() -> void:
	# Trocar o nome da cena principal!
	PlayerSingleton.visible = true
	ScoreSingleton.get_child(0).show()
	HudSingleton.get_child(0).show()
	PlayerSingleton.position.x = 50
	PlayerSingleton.position.y = 50
	ScoreSingleton.reset()
	get_tree().change_scene("res://scenes/School.tscn")
