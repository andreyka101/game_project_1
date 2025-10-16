extends Area2D


var death = true
@onready var level = $"../.."
@onready var timer:Timer = $Timer
@onready var marker:Marker2D = $Marker2D
@onready var timer_position:Timer = $Timer_position
@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"
@onready var bullets_of_enemies:Node2D = $"../../Bullets_of_enemies"
@onready var super_enemy_star: Sprite2D = $Super_enemy_star
@onready var timer_star: Timer = $Timer_star

var position_save = Vector2(randi_range(10 , 710) , randi_range(40 , 1100))

var name_str = "regular ship"

var hp
var damage_ship
var damage_enemyBullet
var speed_ship
var speed_enemyBullet
var timer_num:Array
var timer_position_num:Array
var enemy_level = 1
var super_enemy = false
var mega_enemy = false
var move_star:Vector2
var speed_rotation_star



func _ready() -> void:
	if(super_enemy):
		enemy_level += 1
		var num_scale_star = randf_range(0.3 , 0.5)
		super_enemy_star.scale = Vector2(num_scale_star , num_scale_star)
		super_enemy_star.visible = true
		if (randi_range(0, 1) == 1):
			speed_rotation_star = randf_range(2 , 7)
		else:
			speed_rotation_star = randf_range(-2 , -7)
		if (randi_range(0, 1) == 1):
			super_enemy_star.position = Vector2(randf_range(-20,20) , randf_range(-30,5))
			move_star = Vector2(randf_range(-20,20) , randf_range(-30,5))
		else:
			super_enemy_star.position = Vector2(randf_range(-14,14) , randf_range(5,20))
			move_star = Vector2(randf_range(-14,14) , randf_range(5,20))
	elif(mega_enemy):
		enemy_level += 2
		super_enemy_star.modulate = "ff0000"
		var num_scale_star = randf_range(0.3 , 0.5)
		super_enemy_star.scale = Vector2(num_scale_star , num_scale_star)
		super_enemy_star.visible = true
		if (randi_range(0, 1) == 1):
			speed_rotation_star = randf_range(2 , 7)
		else:
			speed_rotation_star = randf_range(-2 , -7)
		if (randi_range(0, 1) == 1):
			super_enemy_star.position = Vector2(randf_range(-20,20) , randf_range(-30,5))
			move_star = Vector2(randf_range(-20,20) , randf_range(-30,5))
		else:
			super_enemy_star.position = Vector2(randf_range(-14,14) , randf_range(5,20))
			move_star = Vector2(randf_range(-14,14) , randf_range(5,20))
		

	if(enemy_level >= 1 and enemy_level < 5):
		timer_num = [3,4.5]
		timer_position_num = [10,18]
		speed_ship = 80
		speed_enemyBullet = 300
	if(enemy_level >= 5 and enemy_level < 10):
		timer_num = [2.5,4]
		timer_position_num = [9,17]
		speed_ship = 100
		speed_enemyBullet = 310
	if(enemy_level >= 10 and enemy_level < 20):
		timer_num = [2,3.5]
		timer_position_num = [8,16]
		speed_ship = 120
		speed_enemyBullet = 320
	if(enemy_level >= 20 and enemy_level < 30):
		timer_num = [1.5,3]
		timer_position_num = [7,15]
		speed_ship = 140
		speed_enemyBullet = 330
	if(enemy_level >= 30 and enemy_level < 40):
		timer_num = [1,3]
		timer_position_num = [6,14]
		speed_ship = 170
		speed_enemyBullet = 340
	if(enemy_level >= 40 and enemy_level < 50):
		timer_num = [1,2.5]
		timer_position_num = [5,13]
		speed_ship = 200
		speed_enemyBullet = 350
	if(enemy_level >= 50 and enemy_level < 60):
		timer_num = [1,2.5]
		timer_position_num = [4,11]
		speed_ship = 250
		speed_enemyBullet = 360
	if(enemy_level >= 60 and enemy_level < 80):
		timer_num = [1,2]
		timer_position_num = [3,9]
		speed_ship = 300
		speed_enemyBullet = 370
	if(enemy_level >= 80 and enemy_level < 100):
		timer_num = [0.7,2]
		timer_position_num = [2,6]
		speed_ship = 350
		speed_enemyBullet = 380
	if(enemy_level >= 100):
		timer_num = [0.5,2]
		timer_position_num = [1.5,4]
		speed_ship = 400
		speed_enemyBullet = 390


		# speed_ship = 80
		# speed_enemyBullet = 300


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
		damage_enemyBullet = enemy_level * 40


	timer_position.start(randf_range(timer_position_num[0] , timer_position_num[1]))
	await get_tree().create_timer(randf_range(0 , 0.5)).timeout
	timer.start(randf_range(timer_num[0] , timer_num[1]))
	
	

func _physics_process(delta: float) -> void:
	if(Global.stop_game):
		timer.paused = true
		timer_position.paused = true
		timer_star.paused = true
	else:
		timer.paused = false
		timer_position.paused = false
		timer_star.paused = false

	# движение корабля
	if(hp <= 0 and death):
		death = false
		# if (Global.stop_game):
		# 	sprite2D.stop()
		# else:
		# 	sprite2D.play_backwards()
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()
	if((position.x <= position_save.x - 15 or position.x >= position_save.x + 15) or (position.y <= position_save.y - 15 or position.y >= position_save.y + 15)) and death and !Global.stop_game:
		self.position += self.position.direction_to(position_save) * speed_ship * delta

	if((super_enemy or mega_enemy) and !Global.stop_game):
		super_enemy_star.position += super_enemy_star.position.direction_to(move_star) * 30 * delta
		super_enemy_star.rotation_degrees += speed_rotation_star
		if (super_enemy_star.rotation_degrees >= 360):
			super_enemy_star.rotation_degrees -= 360
		if (super_enemy_star.rotation_degrees <= -360):
			super_enemy_star.rotation_degrees += 360
		


# создаем пулю раз в какое-то время
func _on_timer_timeout() -> void:
	#print("on_timer_timeout")
	if(death and !Global.stop_game):
		var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
		var bullet:Area2D = bullet_scene.instantiate()
		bullet.global_position = marker.global_position
		bullet.damage_bullet = damage_enemyBullet
		bullet.speed_bullet = speed_enemyBullet
		bullets_of_enemies.add_child(bullet)
	timer.wait_time = randf_range(timer_num[0] , timer_num[1])


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Galaxy_ship" and death):
		death = true
		body.hp_player -= damage_ship
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
			if(hp <= 0 and death):
				death = false
				sprite2D.play("explosion")
				await sprite2D.animation_finished
				var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
				var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
				level.add_child(enemy_explosion_sound)
				self.queue_free()



# раз в какое-то время корабль меняет своё направление
func _on_timer_position_timeout() -> void:
	if (!Global.stop_game):
		position_save = Vector2(randi_range(10 , 710) , randi_range(40 , 1100))
		# меняем время срабатывания этого таймера
	timer_position.wait_time = randf_range(timer_position_num[0] , timer_position_num[1])


func _on_timer_star_timeout() -> void:
	if(super_enemy or mega_enemy):
		if (randi_range(0, 1) == 1):
			move_star = Vector2(randf_range(-20,20) , randf_range(-30,5))
		else:
			move_star = Vector2(randf_range(-14,14) , randf_range(5,20))
