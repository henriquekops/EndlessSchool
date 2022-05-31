extends KinematicBody2D

class_name Player

enum Direction {UP, DOWN, LEFT, RIGHT}

signal passiveItemConsumed
signal passiveItemReleased
signal activeItemConsumed
signal activeItemReleased
signal inventoryClear

export var speed: int = 400
export var inventory_capacity: int = 3


var sceneLimit : Position2D
var player : KinematicBody2D
var velocity: Vector2
var collision: KinematicCollision2D
var defaultTexture: Texture

onready var timer: Timer = $Timer
onready var sprite: Sprite = $Sprite
onready var projectileSource = $ProjectileSource
onready var Projectile = preload("res://scenes/Projectile.tscn")
onready var screen_size: Vector2 = get_viewport_rect().size


onready var animatedSprite: AnimatedSprite = $AnimatedSprite

var currentScene = null
var inventory_acc = 0
var passive_status = false
var active = true

#sala atual

var curRoomX = 1;
var curRoomY = 1;


var level: int = 1;

var random = RandomNumberGenerator.new();

var curSide = -1;

func _ready() -> void:
	currentScene = get_child(0)
	sceneLimit = currentScene.get_node("SceneLimit") 
	player = currentScene.get_node("Player")
	random.randomize();
	timer.connect("timeout", self, "_on_Timer_timeout")
	#defaultTexture = sprite.texture

func _input(event):
	if inventory_acc > 0 && active:
		if event.is_action_pressed("Item Up"):
			shoot(Direction.UP)
		elif event.is_action_pressed("Item Down"):
			shoot(Direction.DOWN)
		elif event.is_action_pressed("Item Left"):
			shoot(Direction.LEFT)
		elif event.is_action_pressed("Item Right"):
			shoot(Direction.RIGHT)

func _physics_process(delta: float) -> void:
	velocity = move().normalized() * speed * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50+90, screen_size.y-50)
	collision = move_and_collide(velocity)
	if(velocity[0] == 0 && velocity[1] == 0):
		animatedSprite.stop();
		animatedSprite.frame = 0;
	if collision != null:
		if collision.collider.name == "Enemy":
			#call_deferred("free")
			PlayerSingleton.visible = false
			HudSingleton.get_child(0).hide()
			emit_signal("inventoryClear")
			inventory_acc = 0
			passive_status = false
			get_tree().change_scene("res://Scenes/GameOver.tscn")
		
	

func _on_Timer_timeout():
	#sprite.texture = defaultTexture
	speed = speed / 2
	animatedSprite.speed_scale /= 2;
	timer.stop()
	passive_status = false
	emit_signal("passiveItemReleased")

func move() -> Vector2:
	velocity = Vector2.ZERO
	if active:
		if Input.is_action_pressed("Move Up"):
			velocity.y -= 1
		if Input.is_action_pressed("Move Down"):
			velocity.y += 1
		if Input.is_action_pressed("Move Right"):
			velocity.x += 1
			curSide = 1
		if Input.is_action_pressed("Move Left"):
			velocity.x -= 1
			curSide = -1
	if(curSide == -1):
		animatedSprite.play("left");
	else:
		animatedSprite.play("right");
			
	return velocity

func _on_Area2D_area_entered(area):
	if area.get_groups()[0] == "item":
		apply_item_effect(area)

func apply_item_effect(item):
	if item.TYPE == "passive" && !passive_status:
		if item.effect == item.Effect.VELOCITY:
			#sprite.texture = item.sprite.texture
			speed = speed * 2
			animatedSprite.speed_scale *= 2;
		timer.start(5)
		item.queue_free()
		passive_status = true
		emit_signal("passiveItemConsumed")
	elif item.TYPE == "active":
		if inventory_acc < inventory_capacity:
			#sprite.texture = item.sprite.texture
			inventory_acc += 1
			item.queue_free()
			emit_signal("activeItemConsumed")

func shoot(direction):
	inventory_acc -= 1
	var p = Projectile.instance()
	get_parent().add_child(p)
	p.position = projectileSource.global_position
	p.direction = direction
	emit_signal("activeItemReleased")
	#if inventory_acc == 0:
		#sprite.texture = defaultTexture
