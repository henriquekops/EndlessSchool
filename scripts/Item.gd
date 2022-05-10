extends Area2D

class_name Item

signal consumed(type, effect)

enum Type {PASSIVE, ACTIVE}
enum Effect {VELOCITY, RANGE, STRENGTH}

export (Type) var type: int = Type.PASSIVE
export (Effect) var effect: int = Effect.VELOCITY

var activeSpriteTexture = preload("res://assets/activeItemSprite.png")
var passiveSpriteTexture = preload("res://assets/passiveItemSprite.jpg")

onready var sprite: Sprite = $Sprite
#onready var window_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	#position = Vector2(window_size.x/2, window_size.y/2+100)
	if type == Type.ACTIVE:
		sprite.texture = activeSpriteTexture
	elif type == Type.PASSIVE:
		sprite.texture = passiveSpriteTexture

func _on_Item_body_entered(body: Node) -> void:
	if body != null:
		if body.name == "Player":
			emit_signal("consumed", type, effect)
			call_deferred("free")
