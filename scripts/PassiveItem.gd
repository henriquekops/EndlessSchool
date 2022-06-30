extends Area2D

class_name PassiveItem

enum Effect {VELOCITY, STRENGTH, FOV}

export (Effect) var effect = Effect.VELOCITY

var framei = 0;

const TYPE = "passive";

func _ready():
	var spriteshoes = load("res://assets/Shoes.png");
	var spriteglasses = load("res://assets/Glasses.png");
	var ashoes = load("");
	var aglasses = load("res://assets/GlassesSheet.png");
	var sprite: Sprite = $Sprite;
	var animatedSprite: AnimatedSprite = $AnimatedSprite
	if effect == Effect.VELOCITY:
		sprite.texture = spriteshoes;
		sprite.visible = true;
		animatedSprite.visible = false;
	elif effect == Effect.FOV:
		#sprite.texture = spriteglasses;
		animatedSprite.visible = true;
		
		

func _physics_process(delta: float) -> void:
	if effect == Effect.FOV:
		framei = framei + 1;
		if framei >= 30:
			framei = 0;
			$AnimatedSprite.frame = ($AnimatedSprite.frame + 1) % 5;
		
