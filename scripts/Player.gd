extends KinematicBody2D

class_name Player

export var speed: int = 400

var sceneLimit : Position2D
var player : KinematicBody2D

var velocity: Vector2
var collision: KinematicCollision2D

onready var timer: Timer = $Timer

onready var sprite: Sprite = $Sprite
onready var screen_size: Vector2 = get_viewport_rect().size
var currentScene = null

#sala atual

var curRoomX = 1;
var curRoomY = 1;


var level: int = 1;

var random = RandomNumberGenerator.new();

func _ready() -> void:
	currentScene = get_child(0)
	sceneLimit = currentScene.get_node("SceneLimit") 
	player = currentScene.get_node("Player")
	random.randomize();
	timer.connect("timeout", self, "_on_Timer_timeout")

func _physics_process(delta: float) -> void:
	velocity = move().normalized() * speed * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50, screen_size.y-50)
	collision = move_and_collide(velocity)
	if collision != null:
		if collision.collider.name == "Enemy":
			call_deferred("free")
			get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_Timer_timeout():
	speed = speed / 2
	timer.stop()

func move() -> Vector2:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move Left"):
		velocity.x -= 1
	return velocity

func _on_Area2D_area_entered(area):
	if area.get_groups()[0] == "item":
		apply_item_effect(area)
		area.queue_free()

func apply_item_effect(item):
	if item.type == item.Type.PASSIVE:
		if item.effect == item.Effect.VELOCITY:
			speed = speed * 2
		timer.start(5)
	elif item.type == item.Type.ACTIVE:
		print("bruh")
		sprite.texture = item.sprite.texture
