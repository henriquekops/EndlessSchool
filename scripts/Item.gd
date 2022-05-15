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

func _ready() -> void:
	if type == Type.ACTIVE:
		sprite.texture = activeSpriteTexture
	elif type == Type.PASSIVE:
		sprite.texture = passiveSpriteTexture
