extends CanvasLayer

class_name HUD

onready var activeItems = HudSingleton.get_child(0).get_child(3).get_children()
onready var passiveItems = HudSingleton.get_child(0).get_child(2).get_children()
onready var mutex = Mutex.new()
onready var player = PlayerSingleton

var passiveItemCount = 0
var activeItemCount = 0

signal activeItemShot

func _ready():
	MusicController.play_music()
	player.connect("activeItemConsumed", self, "_on_Player_activeItemConsumed")
	player.connect("activeItemReleased", self, "_on_Player_activeItemReleased")
	player.connect("passiveItemConsumed", self, "_on_Player_passiveItemConsumed")
	player.connect("passiveItemReleased", self, "_on_Player_passiveItemReleased")
	player.connect("inventoryClear", self, "_on_Player_inventoryClear")

func _on_Player_activeItemConsumed(texture):
	mutex.lock()
	activeItems[activeItemCount].texture = texture
	activeItemCount += 1
	mutex.unlock()

func _on_Player_activeItemReleased(projectile):
	mutex.lock()
	activeItemCount -= 1
	projectile.get_node("Sprite").texture = load(activeItems[activeItemCount].texture.get_path())
	activeItems[activeItemCount].texture = null
	mutex.unlock()
	
func _on_Player_passiveItemConsumed(texture):
	mutex.lock()
	passiveItems[passiveItemCount].texture = texture
	passiveItemCount += 1
	mutex.unlock()

func _on_Player_passiveItemReleased():
	mutex.lock()
	passiveItemCount -= 1
	passiveItems[passiveItemCount].texture = null
	mutex.unlock()

func _on_Player_inventoryClear():
	passiveItems[0].texture = null
	activeItems[0].texture = null
	activeItems[1].texture = null
	activeItems[2].texture = null
	activeItemCount = 0
	passiveItemCount = 0
	
