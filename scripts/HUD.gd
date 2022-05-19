extends CanvasLayer

class_name HUD

onready var activeItems = $ActiveItems.get_children()
onready var passiveItems = $PassiveItems.get_children()
onready var player = PlayerSingleton

var passiveItemCount = 0
var activeItemCount = 0

func _ready():
	player.connect("activeItemConsumed", self, "_on_Player_activeItemConsumed")
	player.connect("activeItemReleased", self, "_on_Player_activeItemReleased")
	player.connect("passiveItemConsumed", self, "_on_Player_passiveItemConsumed")
	player.connect("passiveItemReleased", self, "_on_Player_passiveItemReleased")
	for item in activeItems:
		item.visible = false
	for item in passiveItems:
		item.visible = false

func _on_Player_activeItemConsumed():
	activeItems[activeItemCount].visible = true
	activeItemCount += 1

func _on_Player_activeItemReleased():
	activeItemCount -= 1
	activeItems[activeItemCount].visible = false
	
func _on_Player_passiveItemConsumed():
	passiveItems[passiveItemCount].visible = true
	passiveItemCount += 1

func _on_Player_passiveItemReleased():
	passiveItemCount -= 1
	passiveItems[passiveItemCount].visible = false
	
