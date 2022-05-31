extends CanvasLayer

class_name HUD

onready var activeItems = HudSingleton.get_child(0).get_child(3).get_children()
onready var passiveItems = HudSingleton.get_child(0).get_child(2).get_children()
onready var player = PlayerSingleton

var passiveItemCount = 0
var activeItemCount = 0

func _ready():
	player.connect("activeItemConsumed", self, "_on_Player_activeItemConsumed")
	player.connect("activeItemReleased", self, "_on_Player_activeItemReleased")
	player.connect("passiveItemConsumed", self, "_on_Player_passiveItemConsumed")
	player.connect("passiveItemReleased", self, "_on_Player_passiveItemReleased")
	player.connect("inventoryClear", self, "_on_Player_inventoryClear")
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
	
func _on_Player_inventoryClear():
	passiveItems[0].visible = false
	activeItems[0].visible = false
	activeItems[1].visible = false
	activeItems[2].visible = false
	activeItemCount = 0
	passiveItemCount = 0
	
