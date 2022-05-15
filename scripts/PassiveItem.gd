extends Area2D

class_name PassiveItem

enum Effect {VELOCITY, STRENGTH, FOV}

export (Effect) var effect = Effect.VELOCITY

onready var sprite: Sprite = $Sprite

const TYPE = "passive"
