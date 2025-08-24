extends CharacterBody2D


@onready var level = $".."
@onready var marker:Marker2D = $"./Marker2D"
var attack_bool:bool = false
var hp_player = 500
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
var not_death = true
@onready var timer: Timer = $Timer
@onready var player_bullets: Node2D = $"../Player_bullets"
# @onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D
var hp_start_player = 500
# 250
var stop = false
var speed_ship = 300
var speed_bullet = 600
var damage = 150
var time_timer = 0.7

var acceleration = 500.0
var current_speed = 0.0
var target_speed = 0.0






func  _physics_process(delta: float) -> void:
	#print(hp_player)
	
	
	# меняем анимацию исходя от процента hp
	if (!Global.stop_game):
		if((hp_start_player/100) * 100 >= hp_player and (hp_start_player/100) * 75 < hp_player and not_death):
			#print(hp_player)
			sprite.play("100-75%")
		elif((hp_start_player/100) * 75 >= hp_player and (hp_start_player/100) * 50 < hp_player and not_death):
			#print(hp_player)
			sprite.play("75-50%")
		elif((hp_start_player/100) * 50 >= hp_player and (hp_start_player/100) * 25 < hp_player and not_death):
			#print(hp_player)
			sprite.play("50-25%")
		elif((hp_start_player/100) * 25 >= hp_player and (hp_start_player/100) * 0 < hp_player and not_death):
			#print(hp_player)
			sprite.play("25-0%")
	else:
		sprite.stop()
	

	# если hp у корабля меньше или равен нулю то
	if(hp_player <= 0 and not_death):
		hp_player = 0
		not_death = false
		# корабль взрывается 
		sprite.play("explosion")
		await sprite.animation_finished
		# а потом удаляется
		self.queue_free()
		#get_tree().change_scene_to_file("res://ALL_scenes/menu/menu.tscn")
		
		

	# get_global_mouse_position() - получаем координаты мыши относительно глобальной сцены (level.gd)

	# корабль движется за мышкой
	#self.position.x = get_global_mouse_position().x
	#self.position.y = get_global_mouse_position().y
	
	# тоже самое но в одну строку
	#self.position = get_global_mouse_position()
	
	#print(position)
	

	# position.direction_to(x) - вычисляет плавное движение к точке x





	# движение корабля 
	if((position.x <= get_global_mouse_position().x - 15 or position.x >= get_global_mouse_position().x + 15) or (position.y <= get_global_mouse_position().y - 15 or position.y >= get_global_mouse_position().y + 15)) and not_death and !stop and !Global.stop_game:

		# self.global_position +=  self.position.direction_to(get_global_mouse_position())  * 300 * 5 * delta
		self.velocity =  self.position.direction_to(get_global_mouse_position())  * speed_ship
		
	else:
		velocity = Vector2(0,0)


	# target_speed =  self.position.direction_to(get_global_mouse_position()) * speed_ship
	# self.velocity = current_speed * delta
	# position = position.lerp(get_global_mouse_position(), speed_ship)
	# print(position.lerp(get_global_mouse_position(), speed_ship))

	move_and_slide()



	# if((position.x <= get_global_mouse_position().x - 15 or position.x >= get_global_mouse_position().x + 15) and not_death and !stop):

	# 	# self.global_position +=  self.position.direction_to(get_global_mouse_position())  * 300 * 5 * delta

	# 	if(position.x < get_global_mouse_position().x):
	# 		velocity.x = 300
	# 	elif(position.x > get_global_mouse_position().x):
	# 		velocity.x = -300
	# else:
	# 	velocity.x = 0
	# if((position.y <= get_global_mouse_position().y - 15 or position.y >= get_global_mouse_position().y + 15) and not_death and !stop):

	# 	if(position.y < get_global_mouse_position().y):
	# 		velocity.y = 300
	# 	elif(position.y > get_global_mouse_position().y):
	# 		velocity.y = -300
	# else:
	# 	velocity.y = 0
	# # else:
	# # 	velocity = Vector2(0,0)
	# move_and_slide()


func _process(delta: float):
	# включение / выключение атаки
	#if(Input.is_action_just_pressed("attack")):
		#attack_bool = true
	#if(Input.is_action_just_released("attack")):
		#attack_bool = false
	if(stop):
		self.visible = false
	else:
		self.visible = true
	attack_bool = true

	if(hp_player < 0):
		hp_player = 0
	
	if(Global.stop_game):
		timer.paused = true
	else:
		timer.paused = false



# сигнал узла timer срабатывает раз в какое-то время
func _on_timer_timeout() -> void:

	if(attack_bool and not_death and !stop):
		var bullet_scene = load("res://ALL_scenes/bullet/bullet.tscn")
		var bullet:CharacterBody2D = bullet_scene.instantiate()
		bullet.global_position  = marker.global_position 
		bullet.speed = speed_bullet
		bullet.damage_bullet = damage


		var player_shot_sound_scene = load("res://ALL_scenes/player_shot_sound/player_shot_sound.tscn")
		var player_shot_sound = player_shot_sound_scene.instantiate()
		level.add_child(player_shot_sound)


		player_bullets.add_child(bullet)





		
