extends CharacterBody2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"
@onready var timer:Timer = $Timer
@onready var marker_RIGHT:Marker2D = $Marker2D_RIGHT
@onready var marker_LEFT:Marker2D = $Marker2D_LEFT
@onready var level = $"../.."
# var hp = 100
@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"
@onready var collisionPolygon:CollisionPolygon2D = $CollisionPolygon2D
@onready var bullets_of_enemies:Node2D = $"../../Bullets_of_enemies"


var distance_from_player_X = null
var direction = null
var death = false
var shooting = false
var speed = 200

var name_str = "shooting drone"

var hp
var damage_ship
var damage_enemyBullet
var speed_ship
var speed_enemyBullet
var timer_num:Array
var enemy_level = 1


func _ready() -> void:
	# меняет время срабатывания таймера
	#timer.wait_time = randf_range(1 , 3)

	# запускаем и меняет время срабатывания таймера
	# timer.start(randf_range(1 , 2))
	# if(enemy_level >= 1 and enemy_level < 5):
	# 	timer_num = [3,4.5]
	# 	timer_position_num = [10,18]
	# 	speed_ship = 80
	# 	speed_enemyBullet = 300
	# if(enemy_level >= 5 and enemy_level < 10):
	# 	timer_num = [2.5,4]
	# 	timer_position_num = [9,17]
	# 	speed_ship = 100
	# 	speed_enemyBullet = 310
	# if(enemy_level >= 10 and enemy_level < 20):
	# 	timer_num = [2,3.5]
	# 	timer_position_num = [8,16]
	# 	speed_ship = 120
	# 	speed_enemyBullet = 320
	# if(enemy_level >= 20 and enemy_level < 30):
	# 	timer_num = [1.5,3]
	# 	timer_position_num = [7,15]
	# 	speed_ship = 140
	# 	speed_enemyBullet = 330
	# if(enemy_level >= 30 and enemy_level < 40):
	# 	timer_num = [1,3]
	# 	timer_position_num = [6,14]
	# 	speed_ship = 170
	# 	speed_enemyBullet = 340
	# if(enemy_level >= 40 and enemy_level < 50):
	# 	timer_num = [1,2.5]
	# 	timer_position_num = [5,13]
	# 	speed_ship = 200
	# 	speed_enemyBullet = 350
	# if(enemy_level >= 50 and enemy_level < 60):
	# 	timer_num = [1,2.5]
	# 	timer_position_num = [4,11]
	# 	speed_ship = 250
	# 	speed_enemyBullet = 360
	# if(enemy_level >= 60 and enemy_level < 80):
	# 	timer_num = [1,2]
	# 	timer_position_num = [3,9]
	# 	speed_ship = 300
	# 	speed_enemyBullet = 370
	# if(enemy_level >= 80 and enemy_level < 100):
	# 	timer_num = [0.7,2]
	# 	timer_position_num = [2,6]
	# 	speed_ship = 350
	# 	speed_enemyBullet = 380
	# if(enemy_level >= 100):
	# 	timer_num = [0.5,2]
	# 	timer_position_num = [1.5,4]
	# 	speed_ship = 400
	# 	speed_enemyBullet = 390


	if(enemy_level >= 1 and enemy_level <= 10):
		hp = (enemy_level * 0.5 + 0.5) * 100
		damage_ship = (((enemy_level * 0.5 + 0.5) * 100) /10.0)*7
		damage_enemyBullet = 10 + (enemy_level * 5)
	elif(enemy_level > 10 and enemy_level < 20):
		hp = enemy_level * 0.6 * 100
		damage_ship = ((enemy_level * 0.6 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 7
	elif(enemy_level >= 20 and enemy_level < 30):
		hp = enemy_level * 0.7 * 100
		damage_ship = ((enemy_level * 0.7 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 8
	elif(enemy_level >= 30 and enemy_level < 40):
		hp = enemy_level * 0.8 * 100
		damage_ship =((enemy_level * 0.8 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 9
	elif(enemy_level >= 40 and enemy_level < 50):
		hp = enemy_level * 0.9 * 100
		damage_ship = ((enemy_level * 0.9 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 10
	elif(enemy_level >= 50 and enemy_level < 60):
		hp = enemy_level * 100
		damage_ship = ((enemy_level * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 10
	elif(enemy_level >= 60 and enemy_level < 80):
		hp = enemy_level * 1.5 * 100
		damage_ship = ((enemy_level * 1.5 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 15
	elif(enemy_level >= 80 and enemy_level < 100):
		hp = enemy_level * 2.5 * 100
		damage_ship = ((enemy_level * 2.5 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 25
	elif(enemy_level >= 100):
		hp = enemy_level * 4 * 100
		damage_ship = ((enemy_level * 4 * 100) /10.0)*7
		damage_enemyBullet = enemy_level * 4


	timer.start(randf_range(timer_num[0] , timer_num[1]))


func _physics_process(delta: float) -> void:
	if(Global.stop_game):
		timer.paused = true
	else:
		timer.paused = false


	# print(velocity)
	if(not shooting and galaxy_ship and !death and !Global.stop_game):
		if(galaxy_ship.position and !Global.stop_game and (position.x <= galaxy_ship.position.x - 15 or position.x >= galaxy_ship.position.x + 15)):
			if(galaxy_ship.position.x - self.position.x > 0):
				self.velocity.x = speed
			else:
				self.velocity.x = -speed
		else:
			self.velocity.x = 0
		velocity.y = 75
	else:
		self.velocity = Vector2(0,0)
		

		if(hp <= 0 and !death):
			death = true
			collisionPolygon.visible = false
			sprite2D.play("explosion")
			await sprite2D.animation_finished
			var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
			var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
			level.add_child(enemy_explosion_sound)
			self.queue_free()
	


	if(position.y > 1700):
		self.queue_free()

	move_and_slide()

func _on_timer_timeout() -> void:
		timer.wait_time = randf_range(1 , 2)
		if(not death and !Global.stop_game):
			shooting = true
			#await get_tree().create_timer(0.3).timeout
			
			var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
			
			var bullet_RIGHT:Area2D = bullet_scene.instantiate()
			bullet_RIGHT.speed_bullet = bullet_RIGHT.speed_bullet * 1.5
			bullet_RIGHT.global_position = marker_RIGHT.global_position
			bullets_of_enemies.add_child(bullet_RIGHT)
			
			var bullet_LEFT:Area2D = bullet_scene.instantiate()
			bullet_LEFT.speed_bullet = bullet_LEFT.speed_bullet * 1.5
			bullet_LEFT.global_position = marker_LEFT.global_position
			bullets_of_enemies.add_child(bullet_LEFT)
			
			# таймер будет срабатывать в случайное время
			#await get_tree().create_timer(0.1).timeout
			shooting = false


# func _on_body_entered(body: Node2D) -> void:


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Galaxy_ship" and !death):
		death = true
		body.hp_player -= 70
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()


	for i_group in body.get_groups():
		#print(i_group)
		# если в группе есть пуля то наносим урон кораблю и удаляем пулю
		if(i_group == "group_bullet"):
			hp -= body.damage_bullet
			body.queue_free()
			if(hp > 0):
				sprite2D.self_modulate = "#ff4551"
				await get_tree().create_timer(0.2).timeout
				sprite2D.self_modulate = "#fff"
				var enemy_hit_sound_scene = load("res://ALL_scenes/enemy_hit_sound/enemy_hit_sound.tscn")
				var enemy_hit_sound = enemy_hit_sound_scene.instantiate()
				level.add_child(enemy_hit_sound) 
			
			
			# смерть корабля
			if(hp <= 0 and !death):
				death = true
				collisionPolygon.visible = false
				sprite2D.play("explosion")
				await sprite2D.animation_finished
				var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
				var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
				level.add_child(enemy_explosion_sound)
				self.queue_free()
