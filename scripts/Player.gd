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



var velocity: Vector2
var collision: KinematicCollision2D
var defaultTexture: Texture

onready var timer: Timer = $Timer
onready var projectileSource = $ProjectileSource
onready var Projectile = preload("res://scenes/Projectile.tscn")
onready var screen_size: Vector2 = get_viewport_rect().size
onready var rangeArea: Area2D = $Area2D
onready var hud = HudSingleton

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

export var shootrange = 1;

var tipoItem = "";

func _ready() -> void:
	currentScene = get_child(0)
	random.randomize();
	timer.connect("timeout", self, "_on_Timer_timeout")
	hud.connect("activeItemShot", self, "_on_Hud_activeItemShot")
	animatedSprite.speed_scale *= 1.5;
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
		if(curSide == -1):
			animatedSprite.play("stillLeft");
		else:
			animatedSprite.play("stillRight");
		#animatedSprite.stop();
		animatedSprite.frame = 0;
	if collision != null:
		if collision.collider.name == "Enemy":
			#call_deferred("free")
			reset()
			get_tree().change_scene("res://Scenes/GameOver.tscn")
		
func reset():
	PlayerSingleton.visible = false
	HudSingleton.get_child(0).hide()
	emit_signal("inventoryClear")
	inventory_acc = 0
	passive_status = false
	if(timer.time_left > 0):
		timer.stop()
		speed = 400
		animatedSprite.speed_scale = 1;
		shootrange = 1
		
func _on_Timer_timeout():
	#sprite.texture = defaultTexture
	match tipoItem:	
		"VELOCITY": 
			speed = speed / 2
			animatedSprite.speed_scale /= 2;
			continue
		"FOV":
			shootrange = 1
			continue

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
			tipoItem = "VELOCITY";
			speed = speed * 2
			animatedSprite.speed_scale *= 2;
			emit_signal("passiveItemConsumed", load("res://assets/Shoes.png"))
		elif item.effect == item.Effect.FOV:
			tipoItem = "FOV";
			shootrange = 2;
			emit_signal("passiveItemConsumed", load("res://assets/oculos.png"))
		# if item.effect == item.Effect.FOV:
			# increase fov
		
		timer.start(5)
		item.queue_free()
		passive_status = true
	elif item.TYPE == "active":
		if inventory_acc < inventory_capacity:
			if(item.sprite.texture.get_path().split("/")[3] == "BookOpen.png"):
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				var r = rng.randi_range(0,2)
				var i = Image.new()
				match r:
					0: 
						item.sprite.texture = load("res://assets/BookGreen.png")
						continue
					1:
						item.sprite.texture = load("res://assets/BookOrange.png")
						continue
					2:
						item.sprite.texture = load("res://assets/BookPurple.png")
						continue
						
				#item.sprite.texture.set_data()
			inventory_acc += 1
			emit_signal("activeItemConsumed", item.sprite.texture)
			item.queue_free()

func shoot(direction):
	inventory_acc -= 1
	var p = Projectile.instance()
	get_parent().add_child(p)
	p.position = projectileSource.global_position
	p.direction = direction
	emit_signal("activeItemReleased", p)
	#if inventory_acc == 0:
		#sprite.texture = defaultTexture
