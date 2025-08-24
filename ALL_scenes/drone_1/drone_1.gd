extends Area2D

@onready var sprite_head:AnimatedSprite2D =  $AnimatedSprite2D_head
@onready var sprite_fire:AnimatedSprite2D =  $AnimatedSprite2D_fire
@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"
@onready var level = $"../.."
var speed_rotation = 0
#var speed = randf_range(60 , 160)
var speed = 160
var hp = 50
var death = false

var name_str = "explosive drone"

var arr_enemy = []



func _ready() -> void:
	# задаём направление для вращения головы дрона
	if(randi_range(0 ,1) == 1):
		speed_rotation = 5
	else:
		speed_rotation = -5
		
	
	

func _process(delta: float) -> void:
	# if (Global.stop_game):
	# 	sprite_fire.stop()
	# 	sprite_head.stop()

	if (!Global.stop_game):
		# вращаем голову
		sprite_head.rotation_degrees += speed_rotation


	# градус головы не увеличивается больше 360
	if(sprite_head.rotation_degrees >= 360):
		sprite_head.rotation_degrees -= 360
	if(sprite_head.rotation_degrees <= -360):
		sprite_head.rotation_degrees += 360
	#print(sprite_head.rotation_degrees)
	
	
	# дрон всегда смотрит в сторону корабля игрока


	# дрон летит в сторону корабля игрока
	
	
	if(hp <= 0 and !death):
		sprite_fire.play("explosion")
		sprite_head.play("explosion")
		for element_scene in arr_enemy:
			element_scene.hp -= 1000
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
	
	if(galaxy_ship.position != null and !Global.stop_game):
		position += self.position.direction_to(galaxy_ship.position) * speed * delta
		look_at(galaxy_ship.position)
	


func _on_body_entered(body: Node2D) -> void:

	# если касаемся корабля игрока то наносим ему урон и взрываемся
	if(body.name == "Galaxy_ship" and !death):
		body.hp_player -= 150
		sprite_head.play("explosion")
		await sprite_head.animation_finished
		var enemy_explosion_sound_scene = load("res://ALL_scenes/enemy_explosion_sound/enemy_explosion_sound.tscn")
		var enemy_explosion_sound = enemy_explosion_sound_scene.instantiate()
		level.add_child(enemy_explosion_sound)
		self.queue_free()
		
		
	for i_group in body.get_groups():
		#print(i_group)
		# если в группе есть пуля то наносим урон дрону и удаляем пулю
		if(i_group == "group_bullet"):
			hp -= body.damage_bullet
			body.queue_free()
			if(hp > 0):
				sprite_head.self_modulate = "#ff4551"
				await get_tree().create_timer(0.2).timeout
				sprite_head.self_modulate = "#fff"
			
			
			# смерть дрона
			if(hp <= 0 and !death):
				sprite_fire.play("explosion")
				sprite_head.play("explosion")
				for element_scene in arr_enemy:
					element_scene.hp -= 1000
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
		if(el_group == "all_enemy"):
			arr_enemy.append(area)
			


func _on_boom_area_exited(area: Area2D) -> void:
	for el_group in area.get_groups():
		if(el_group == "all_enemy"):
			# print(arr_enemy.find(area))
			arr_enemy.remove_at(arr_enemy.find(area))


func _on_boom_body_entered(body: Node2D) -> void:
	#print(area)
	for el_group in body.get_groups():
		if(el_group == "all_enemy"):
			arr_enemy.append(body)


func _on_boom_body_exited(body: Node2D) -> void:
	for el_group in body.get_groups():
		if(el_group == "all_enemy"):
			# print(arr_enemy.find(area))
			arr_enemy.remove_at(arr_enemy.find(body))
