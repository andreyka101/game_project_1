extends Area2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"

# создаём рандомные координаты x
# var save_X = randi_range(200,520)
var save_X = randi_range(300,780)

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
var mega_enemy = false
var move_star:Vector2
var speed_rotation_star
var stop_time = false
var time_appearance_enemy
var save_time = 0

@onready var level = $"../.."


# var time_save = get_unix_time()




func _ready() -> void:
	time_appearance_enemy = Time.get_unix_time_from_system()

	if(super_enemy):
		enemy_level += 1
		var num_scale_star = randf_range(0.5 , 0.7)
		super_enemy_star.scale = Vector2(num_scale_star , num_scale_star)
		super_enemy_star.visible = true
		if (randi_range(0, 1) == 1):
			speed_rotation_star = randf_range(2 , 7)
		else:
			speed_rotation_star = randf_range(-2 , -7)
		super_enemy_star.position = Vector2(randf_range(-37,37) , randf_range(-37,37))
		move_star = Vector2(randf_range(-37,37) , randf_range(-37,37))
	elif(mega_enemy):
		enemy_level += 2
		super_enemy_star.modulate = "ff0000"
		var num_scale_star = randf_range(0.5 , 0.7)
		super_enemy_star.scale = Vector2(num_scale_star , num_scale_star)
		super_enemy_star.visible = true
		if (randi_range(0, 1) == 1):
			speed_rotation_star = randf_range(2 , 7)
		else:
			speed_rotation_star = randf_range(-2 , -7)
		super_enemy_star.position = Vector2(randf_range(-37,37) , randf_range(-37,37))
		move_star = Vector2(randf_range(-37,37) , randf_range(-37,37))

	var scale_num = randf_range(1.6 , 3.0)
	# var scale_num = 2
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


		# damage = scale_num * ( 60 /10.0)*8
		damage = 3 * ( 50 /10.0)*8
		# hp = scale_num * 60
		hp = 3 * 50


	if(enemy_level >= 1 and enemy_level <= 10):
		hp = ((enemy_level * 0.5 + 0.5) * 50) * scale_num
		damage = ((((enemy_level * 0.5 + 0.5) * 50) * scale_num) /10.0)*8
	elif(enemy_level > 10 and enemy_level < 20):
		hp = (enemy_level * 0.6 * 50) * scale_num
		damage = (((enemy_level * 0.6 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 20 and enemy_level < 30):
		hp = (enemy_level * 0.7 * 50) * scale_num
		damage = (((enemy_level * 0.7 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 30 and enemy_level < 40):
		hp = (enemy_level * 0.8 * 50) * scale_num
		damage =(((enemy_level * 0.8 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 40 and enemy_level < 50):
		hp = (enemy_level * 0.9 * 50) * scale_num
		damage = (((enemy_level * 0.9 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 50 and enemy_level < 60):
		hp = (enemy_level * 50) * scale_num
		damage = (((enemy_level * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 60 and enemy_level < 80):
		hp = (enemy_level * 1.5 * 50) * scale_num
		damage = (((enemy_level * 1.5 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 80 and enemy_level < 100):
		hp = (enemy_level * 2.5 * 50) * scale_num
		damage = (((enemy_level * 2.5 * 50) * scale_num) /10.0)*8
	elif(enemy_level >= 100):
		hp = (enemy_level * 4 * 50) * scale_num
		damage = (((enemy_level * 4 * 50) * scale_num) /10.0)*8




func _process(delta: float) -> void:
	# print("speed =" , speed)
	# print("hp =" , hp)
	# print("damage =" , damage)
	# print("scale =" , scale)
	
	if(Global.stop_game and !stop_time):
		stop_time = true
		save_time = Time.get_unix_time_from_system() - time_appearance_enemy

	if(!Global.stop_game and stop_time):
		stop_time = false
		time_appearance_enemy = Time.get_unix_time_from_system() - save_time


	# метеорит преследует игрока
	#position += self.position.direction_to(galaxy_ship.position) * 300 * delta
	
	# метеорит летит в низ на рандомные координаты по x
	if (!Global.stop_game):
		position += self.position.direction_to(Vector2i(save_X , 2500)) * speed * delta
		timer_star.paused = false
	else:
		timer_star.paused = true
	
	
	# вращение метеорита 
	if (!Global.stop_game):
		sprite2D.rotation_degrees += save_num_rotation
	if(hp <= 0 and !death):
		death = true
		sprite2D.play("explosion")
		save_num_rotation = 0
		await sprite2D.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		print(Time.get_unix_time_from_system() - time_appearance_enemy)
		self.queue_free()
	

	if((super_enemy or mega_enemy) and !Global.stop_game):
		super_enemy_star.position += super_enemy_star.position.direction_to(move_star) * 30 * delta
		super_enemy_star.rotation_degrees += speed_rotation_star
		if (super_enemy_star.rotation_degrees >= 360):
			super_enemy_star.rotation_degrees -= 360
		if (super_enemy_star.rotation_degrees <= -360):
			super_enemy_star.rotation_degrees += 360


	if(position.y > 2500):
		print(Time.get_unix_time_from_system() - time_appearance_enemy)
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
		print(Time.get_unix_time_from_system() - time_appearance_enemy)
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
				print(Time.get_unix_time_from_system() - time_appearance_enemy)
				self.queue_free()
		


func _on_timer_star_timeout() -> void:
	if(super_enemy or mega_enemy):
		move_star = Vector2(randf_range(-37,37) , randf_range(-37,37))
