extends Area2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"

# создаём рандомные координаты x
var save_X = randi_range(200,520)

# создаём рандомную скорость вращения 
var save_num_rotation = randf_range(-5, 5)

# создаём рандомную скорость перемещения

var sprite2D:AnimatedSprite2D
@onready var super_enemy_star: Sprite2D = $Super_enemy_star
@onready var timer_star: Timer = $Timer_star

var death = false

var hp:float
var damage:float
var speed:float
var name_str = "meteorite"
var enemy_level = 1
var super_enemy = false
var move_star:Vector2
var speed_rotation_star

@onready var level = $"../.."




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
		super_enemy_star.position = Vector2(randf_range(-25,25) , randf_range(-25,25))
		move_star = Vector2(randf_range(-25,25) , randf_range(-25,25))

	var scale_num = randf_range(1.6 , 3.0)
	self.scale = Vector2(scale_num  , scale_num)
	sprite2D = $AnimatedSprite2D
	sprite2D.play("meteor " + str(randi_range(1 , 5)))

	if(enemy_level > 0 and enemy_level < 30):
		speed = randf_range(20, 150)
	elif(enemy_level >= 30 and enemy_level < 50):
		speed = randf_range(30, 200)
	elif(enemy_level >= 50 and enemy_level < 70):
		speed = randf_range(40, 200)
	elif(enemy_level >= 70 and enemy_level < 90):
		speed = randf_range(50, 210)
	elif(enemy_level >= 90 and enemy_level < 110):
		speed = randf_range(50, 250)
	elif(enemy_level >= 110 and enemy_level < 210):
		speed = randf_range(50, 300)
	elif(enemy_level >= 210):
		speed = randf_range(70, 350)

	if(enemy_level == 1):
		damage = scale_num * ( 60 /10.0)*7
		hp = scale_num * 60
	elif(enemy_level == 2):
		damage = scale_num * ( 90 /10.0)*7
		hp = scale_num * 90
	elif(enemy_level == 3):
		damage = scale_num * ( 120 /10.0)*7
		hp = scale_num * 120
	elif(enemy_level == 4):
		damage = scale_num * ( 150 /10.0)*7
		hp = scale_num * 150
	elif(enemy_level == 5):
		damage = scale_num * ( 190 /10.0)*7
		hp = scale_num * 190
	elif(enemy_level == 6):
		damage = scale_num * ( 220 /10.0)*7
		hp = scale_num * 220
	elif(enemy_level == 7):
		damage = scale_num * ( 250 /10.0)*7
		hp = scale_num * 250
	elif(enemy_level == 8):
		damage = scale_num * ( 280 /10.0)*7
		hp = scale_num * 280
	elif(enemy_level == 9):
		damage = scale_num * ( 310 /10.0)*7
		hp = scale_num * 310
	elif(enemy_level == 10):
		damage = scale_num * ( 340 /10.0)*7
		hp = scale_num * 340
	elif(enemy_level >= 10 and enemy_level < 60):
		var multiplier = (enemy_level / 10) * 5
		damage = ((scale_num * enemy_level * (multiplier + 35)) /10.0)*7
		hp = scale_num * (multiplier + 35) * enemy_level
	elif(enemy_level >= 60 and enemy_level < 80):
		var multiplier = (enemy_level / 10) * 10
		damage = ((scale_num * enemy_level * (multiplier + 35)) /10.0)*7
		hp = scale_num * (multiplier + 35) * enemy_level
	elif(enemy_level >= 80 and enemy_level < 100):
		var multiplier = (enemy_level / 10) * 15
		damage = ((scale_num * enemy_level * (multiplier + 38)) /10.0)*7
		hp = scale_num * (multiplier + 38) * enemy_level
	elif(enemy_level >= 100):
		var multiplier = (enemy_level / 10) * 21
		damage = ((scale_num * enemy_level * multiplier) /10.0)*7
		hp = scale_num * multiplier * enemy_level




func _process(delta: float) -> void:
	# print("speed =" , speed)
	print("hp =" , hp)
	# print("damage =" , damage)
	# print("scale =" , scale)
	
	# метеорит преследует игрока
	#position += self.position.direction_to(galaxy_ship.position) * 300 * delta
	
	# метеорит летит в низ на рандомные координаты по x
	if (!Global.stop_game):
		position += self.position.direction_to(Vector2i(save_X , 1700)) * speed * delta
		timer_star.paused = false
	else:
		timer_star.paused = true
	
	
	# вращение метеорита 
	if (!Global.stop_game):
		self.rotation_degrees += save_num_rotation
	if(hp <= 0 and !death):
		death = true
		sprite2D.play("explosion")
		save_num_rotation = 0
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


func _on_body_entered(body: Node2D) -> void:
	# возвращает вошедшие группы
	#print(body.get_groups())
	#print(body.name)
	

	
	if(body.name == "Galaxy_ship" and !death):
		death = true
		body.hp_player -= damage
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()
		
		
	for i_group in body.get_groups():
		#print(i_group)
		# если в группе есть пуля то наносим урон метеориту и удаляем пулю
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
			
			
			# смерть метеорита 
			if(hp <= 0 and !death):
				death = true
				sprite2D.play("explosion")
				save_num_rotation = 0
				await sprite2D.animation_finished
				var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
				var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
				level.add_child(enemy_explosion_sound)
				self.queue_free()
		


func _on_timer_star_timeout() -> void:
	if(super_enemy):
		move_star = Vector2(randf_range(-25,25) , randf_range(-25,25))
