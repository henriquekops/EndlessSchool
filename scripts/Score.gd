extends CanvasLayer

onready var scoreLabel := $ScoreLabel
var currentScene = null


func _ready() -> void:
	currentScene = get_child(0)
	scoreLabel.text = "Score: " + str(Global.score)

func updateScore(score) -> void:
	Global.score += score
	scoreLabel.text = "Score: " + str(Global.score)

func reset() -> void:
	Global.score = 0
	scoreLabel.text = "Score: " + str(Global.score)
