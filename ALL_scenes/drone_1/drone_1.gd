extends Area2D

@onready var sprite_head: AnimatedSprite2D = $AnimatedSprite2D_head
@onready var sprite_fire: AnimatedSprite2D = $AnimatedSprite2D_fire
@onready var galaxy_ship: CharacterBody2D = $"../../Galaxy_ship"
@onready var level = $"../.."
@onready var super_enemy_star: Sprite2D = $Super_enemy_star
@onready var timer_star: Timer = $Timer_star
var speed_rotation = 0
#var speed = randf_range(60 , 160)
# var speed = 100
var death = false

var name_str = "explosive drone"

var arr_enemy = []

var hp
var damage
var speed
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

		move_star = Vector2(randf_range(-15,15) , randf_range(-15,15))
		super_enemy_star.position = Vector2(randf_range(-15,15) , randf_range(-15,15))


	# задаём направление для вращения головы дрона
	if (randi_range(0, 1) == 1):
		speed_rotation = 5
	else:
		speed_rotation = -5
	
	if(enemy_level >= 1 and enemy_level < 5):
		speed = 150
	elif(enemy_level >= 5 and enemy_level < 10):
		speed = 175
	elif(enemy_level >= 10 and enemy_level < 20):
		speed = 200
	elif(enemy_level >= 20 and enemy_level < 30):
		speed = 225
	elif(enemy_level >= 30 and enemy_level < 40):
		speed = 250
	elif(enemy_level >= 40 and enemy_level < 50):
		speed = 275
	elif(enemy_level >= 50 and enemy_level < 60):
		speed = 300
	elif(enemy_level >= 60 and enemy_level < 70):
		speed = 350
	elif(enemy_level >= 70 and enemy_level < 80):
		speed = 400
	elif(enemy_level >= 80 and enemy_level < 90):
		speed = 450
	elif(enemy_level >= 90 and enemy_level < 100):
		speed = 500
	elif(enemy_level >= 100 and enemy_level < 150):
		speed = 550
	elif(enemy_level >= 150):
		speed = 600

	if (enemy_level >= 1 and enemy_level <= 10):
		hp = (enemy_level * 0.5 + 0.5) * 50
		damage = (enemy_level * 0.5 + 0.5) * 150
	elif (enemy_level > 10 and enemy_level < 20):
		hp = enemy_level * 0.6 * 50
		damage = enemy_level * 0.6 * 150
	elif (enemy_level >= 20 and enemy_level < 30):
		hp = enemy_level * 0.7 * 50
		damage = enemy_level * 0.7 * 150
	elif (enemy_level >= 30 and enemy_level < 40):
		hp = enemy_level * 0.8 * 50
		damage = enemy_level * 0.8 * 150
	elif (enemy_level >= 40 and enemy_level < 50):
		hp = enemy_level * 0.9 * 50
		damage = enemy_level * 0.9 * 150
	elif (enemy_level >= 50 and enemy_level < 60):
		hp = enemy_level * 50
		damage = enemy_level * 150
	elif (enemy_level >= 60 and enemy_level < 80):
		hp = enemy_level * 1.5 * 50
		damage = enemy_level * 1.5 * 150
	elif (enemy_level >= 80 and enemy_level < 100):
		hp = enemy_level * 2.5 * 50
		damage = enemy_level * 2.5 * 150
	elif (enemy_level >= 100):
		hp = enemy_level * 4 * 50
		damage = enemy_level * 4 * 150
		
	
func _process(delta: float) -> void:
	# if (Global.stop_game):
	# 	sprite_fire.stop()
	# 	sprite_head.stop()
	if (!Global.stop_game):
		# вращаем голову
		sprite_head.rotation_degrees += speed_rotation
		timer_star.paused = false
	else:
		timer_star.paused = true


	# градус головы не увеличивается больше 360
	if (sprite_head.rotation_degrees >= 360):
		sprite_head.rotation_degrees -= 360
	if (sprite_head.rotation_degrees <= -360):
		sprite_head.rotation_degrees += 360
	#print(sprite_head.rotation_degrees)
	
	
	# дрон всегда смотрит в сторону корабля игрока


	# дрон летит в сторону корабля игрока
	
	
	if (hp <= 0 and !death):
		sprite_fire.play("explosion")
		sprite_head.play("explosion")
		for element_scene in arr_enemy:
			element_scene.hp -= damage
		speed_rotation = 0
		speed = 0
		death = true
		await sprite_head.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()
	# print(arr_enemy)
	# for i in arr_enemy:
		# print(i.hp)
	
	if (galaxy_ship.position != null and !Global.stop_game and !death):
		position += self.position.direction_to(galaxy_ship.position) * speed * delta
		look_at(galaxy_ship.position)
	

	if(super_enemy and !Global.stop_game):
		super_enemy_star.position += super_enemy_star.position.direction_to(move_star) * 30 * delta
		super_enemy_star.rotation_degrees += speed_rotation_star
		if (super_enemy_star.rotation_degrees >= 360):
			super_enemy_star.rotation_degrees -= 360
		if (super_enemy_star.rotation_degrees <= -360):
			super_enemy_star.rotation_degrees += 360
	

func _on_body_entered(body: Node2D) -> void:
	# если касаемся корабля игрока то наносим ему урон и взрываемся
	if (body.name == "Galaxy_ship" and !death):
		death = true
		body.hp_player -= damage
		sprite_head.play("explosion")
		sprite_fire.play("explosion")
		await sprite_head.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()
		
		
	for i_group in body.get_groups():
		#print(i_group)
		# если в группе есть пуля то наносим урон дрону и удаляем пулю
		if (i_group == "group_bullet"):
			hp -= body.damage_bullet
			body.queue_free()
			if (hp > 0):
				sprite_head.self_modulate = "#ff4551"
				await get_tree().create_timer(0.2).timeout
				sprite_head.self_modulate = "#fff"
				var enemy_hit_sound_scene = load("res://ALL_scenes/enemy_hit_sound/enemy_hit_sound.tscn")
				var enemy_hit_sound = enemy_hit_sound_scene.instantiate()
				level.add_child(enemy_hit_sound)
			
			
			# смерть дрона
			if (hp <= 0 and !death):
				sprite_fire.play("explosion")
				sprite_head.play("explosion")
				for element_scene in arr_enemy:
					element_scene.hp -= damage
				speed_rotation = 0
				speed = 0
				death = true
				await sprite_head.animation_finished
				var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
				var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
				level.add_child(enemy_explosion_sound)
				self.queue_free()


# func _on_boom_area_entered(area: Area2D) -> void:
# 	print(area)
# 	for el_group in area.get_groups():
# 		print(el_group)
# 		if(el_group == "all_enemy"):
# 			area.hp -= 1000
# 			print(area.hp)


func _on_boom_area_entered(area: Area2D) -> void:
	#print(area)
	for el_group in area.get_groups():
		if (el_group == "all_enemy"):
			arr_enemy.append(area)
			

func _on_boom_area_exited(area: Area2D) -> void:
	for el_group in area.get_groups():
		if (el_group == "all_enemy"):
			# print(arr_enemy.find(area))
			arr_enemy.remove_at(arr_enemy.find(area))


func _on_boom_body_entered(body: Node2D) -> void:
	#print(area)
	for el_group in body.get_groups():
		if (el_group == "all_enemy"):
			arr_enemy.append(body)


func _on_boom_body_exited(body: Node2D) -> void:
	for el_group in body.get_groups():
		if (el_group == "all_enemy"):
			# print(arr_enemy.find(area))
			arr_enemy.remove_at(arr_enemy.find(body))


func _on_timer_star_timeout() -> void:
	if(super_enemy):
		move_star = Vector2(randf_range(-15,15) , randf_range(-15,15))
