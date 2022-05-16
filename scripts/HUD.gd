extends CanvasLayer

onready var activeItems = $ActiveItems.get_children()
onready var passiveItems = $PassiveItems.get_children()

var passiveItemCount = 0
var activeItemCount = 0

func _ready():
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
	
