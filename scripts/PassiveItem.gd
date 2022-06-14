extends Area2D

class_name PassiveItem

enum Effect {VELOCITY, STRENGTH, FOV}

export (Effect) var effect = Effect.VELOCITY


const TYPE = "passive";

func _ready():
	var spriteshoes = load("res://assets/Shoes.png");
	var spriteglasses = load("res://assets/oculos.png");
	var sprite: Sprite = $Sprite;
	if effect == Effect.VELOCITY:
		sprite.texture = spriteshoes;
	elif effect == Effect.FOV:
		sprite.texture = spriteglasses;
	
