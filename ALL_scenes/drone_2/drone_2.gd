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
@onready var super_enemy_star: Sprite2D = $Super_enemy_star
@onready var timer_star: Timer = $Timer_star

var distance_from_player_X = null
var direction = null
var death = false
var shooting = false

var name_str = "shooting drone"

var hp
var damage_drone
var damage_enemyBullet
var speed_drone
var drone_speed_to_side
var speed_enemyBullet
var timer_num:Array
var enemy_level = 1
var super_enemy = false
var move_star:Vector2
var speed_rotation_star


func _ready() -> void:
	if(super_enemy):
		enemy_level += 2
		var num_scale_star = randf_range(0.3 , 0.5)
		super_enemy_star.scale = Vector2(num_scale_star , num_scale_star)
		super_enemy_star.visible = true
		if (randi_range(0, 1) == 1):
			speed_rotation_star = randf_range(2 , 7)
		else:
			speed_rotation_star = randf_range(-2 , -7)
		super_enemy_star.position = Vector2(randf_range(-15,15) , randf_range(-15,25))
		move_star = Vector2(randf_range(-15,15) , randf_range(-15,25))

	# меняет время срабатывания таймера
	#timer.wait_time = randf_range(1 , 3)
	if(enemy_level >= 1 and enemy_level < 5):
		timer_num = [2,3]
		speed_drone = 40
		drone_speed_to_side = 150
		speed_enemyBullet = 300
	if(enemy_level >= 5 and enemy_level < 10):
		timer_num = [1.75,2.75]
		speed_drone = 60
		drone_speed_to_side = 170
		speed_enemyBullet = 310
	if(enemy_level >= 10 and enemy_level < 20):
		timer_num = [1.5,2.5]
		speed_drone = 80
		drone_speed_to_side = 190
		speed_enemyBullet = 320
	if(enemy_level >= 20 and enemy_level < 30):
		timer_num = [1.25,2.25]
		speed_drone = 100
		drone_speed_to_side = 210
		speed_enemyBullet = 330
	if(enemy_level >= 30 and enemy_level < 40):
		timer_num = [1,2]
		speed_drone = 120
		drone_speed_to_side = 230
		speed_enemyBullet = 340
	if(enemy_level >= 40 and enemy_level < 50):
		timer_num = [0.75,2]
		speed_drone = 140
		drone_speed_to_side = 250
		speed_enemyBullet = 350
	if(enemy_level >= 50 and enemy_level < 60):
		timer_num = [0.75,1.75]
		speed_drone = 160
		drone_speed_to_side = 270
		speed_enemyBullet = 360
	if(enemy_level >= 60 and enemy_level < 80):
		timer_num = [0.75,1.5]
		speed_drone = 180
		drone_speed_to_side = 290
		speed_enemyBullet = 370
	if(enemy_level >= 80 and enemy_level < 100):
		timer_num = [0.5,1.5]
		speed_drone = 200
		drone_speed_to_side = 310
		speed_enemyBullet = 380
	if(enemy_level >= 100):
		timer_num = [0.5,1.25]
		speed_drone = 220
		drone_speed_to_side = 330
		speed_enemyBullet = 390


	if(enemy_level >= 1 and enemy_level <= 10):
		hp = (enemy_level * 0.5 + 0.5) * 100
		damage_drone = (((enemy_level * 0.5 + 0.5) * 100) /10.0)*1.7
		damage_enemyBullet = 10 + (enemy_level * 5)
	elif(enemy_level > 10 and enemy_level < 20):
		hp = enemy_level * 0.6 * 100
		damage_drone = ((enemy_level * 0.6 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 7
	elif(enemy_level >= 20 and enemy_level < 30):
		hp = enemy_level * 0.7 * 100
		damage_drone = ((enemy_level * 0.7 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 8
	elif(enemy_level >= 30 and enemy_level < 40):
		hp = enemy_level * 0.8 * 100
		damage_drone =((enemy_level * 0.8 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 9
	elif(enemy_level >= 40 and enemy_level < 50):
		hp = enemy_level * 0.9 * 100
		damage_drone = ((enemy_level * 0.9 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 10
	elif(enemy_level >= 50 and enemy_level < 60):
		hp = enemy_level * 100
		damage_drone = ((enemy_level * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 10
	elif(enemy_level >= 60 and enemy_level < 80):
		hp = enemy_level * 1.5 * 100
		damage_drone = ((enemy_level * 1.5 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 15
	elif(enemy_level >= 80 and enemy_level < 100):
		hp = enemy_level * 2.5 * 100
		damage_drone = ((enemy_level * 2.5 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 25
	elif(enemy_level >= 100):
		hp = enemy_level * 4 * 100
		damage_drone = ((enemy_level * 4 * 100) /10.0)*1.7
		damage_enemyBullet = enemy_level * 4


	timer.start(randf_range(timer_num[0] , timer_num[1]))


func _physics_process(delta: float) -> void:
	if(Global.stop_game):
		timer.paused = true
		timer_star.paused = true
	else:
		timer.paused = false
		timer_star.paused = false


	# print(velocity)
	if(not shooting and galaxy_ship and !death and !Global.stop_game):
		if(galaxy_ship.position and !Global.stop_game and (position.x <= galaxy_ship.position.x - 15 or position.x >= galaxy_ship.position.x + 15)):
			if(galaxy_ship.position.x - self.position.x > 0):
				self.velocity.x = drone_speed_to_side
			else:
				self.velocity.x = -drone_speed_to_side
		else:
			self.velocity.x = 0
		velocity.y = speed_drone
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
	
	if(super_enemy and !Global.stop_game):
		super_enemy_star.position += super_enemy_star.position.direction_to(move_star) * 30 * delta
		super_enemy_star.rotation_degrees += speed_rotation_star
		if (super_enemy_star.rotation_degrees >= 360):
			super_enemy_star.rotation_degrees -= 360
		if (super_enemy_star.rotation_degrees <= -360):
			super_enemy_star.rotation_degrees += 360

	if(position.y > 1700):
		self.queue_free()

	move_and_slide()

func _on_timer_timeout() -> void:
		timer.wait_time = randf_range(timer_num[0] , timer_num[1])
		if(not death and !Global.stop_game):
			shooting = true
			#await get_tree().create_timer(0.3).timeout
			
			var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
			
			var bullet_RIGHT:Area2D = bullet_scene.instantiate()
			bullet_RIGHT.speed_bullet = bullet_RIGHT.speed_bullet * 1.5
			bullet_RIGHT.global_position = marker_RIGHT.global_position
			bullet_RIGHT.damage_bullet = damage_enemyBullet
			bullet_RIGHT.speed_bullet = speed_enemyBullet
			bullets_of_enemies.add_child(bullet_RIGHT)
			
			var bullet_LEFT:Area2D = bullet_scene.instantiate()
			bullet_LEFT.speed_bullet = bullet_LEFT.speed_bullet * 1.5
			bullet_LEFT.global_position = marker_LEFT.global_position
			bullet_LEFT.damage_bullet = damage_enemyBullet
			bullet_LEFT.speed_bullet = speed_enemyBullet
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


func _on_timer_star_timeout() -> void:
	if(super_enemy):
		move_star = Vector2(randf_range(-15,15) , randf_range(-15,25))
