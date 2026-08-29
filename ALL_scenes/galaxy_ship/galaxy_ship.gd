extends CharacterBody2D


@onready var level = $".."
@onready var marker: Marker2D = $"./Marker2D"
var attack_bool: bool = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var not_death = true
@onready var timer: Timer = $Timer
@onready var player_bullets: Node2D = $"../Player_bullets"
# @onready var audio:AudioStreamPlayer2D = $AudioStreamPlayer2D

var hp_player = 300
var hp_start_player = 300
var hp_startStart_player = 300
# 250
var stop = false
var speed_ship_Start = 200
var speed_ship = 200
var speed_bullet_Start = 400
var speed_bullet = 400
var damage_Start = 50
var damage = 50
var time_timer = 1.2

# var hp_player = 3000
# var hp_start_player = 3000
# var hp_startStart_player = 3000
# # 250
# var stop = false
# var speed_ship_Start = 2000
# var speed_ship = 2000
# var speed_bullet_Start = 2400
# var speed_bullet = 2400
# var damage_Start = 500
# var damage = 500
# var time_timer = 0.2

# var acceleration = 500.0
# var current_speed = 0.0
# var target_speed = 0.0


var ability_k1_livingArmor = {"run": false, "num": 0, "plus_hp":0}
@onready var timer_ability_k_1_living_armor: Timer = $Timer_ability_k1_livingArmor

func fun_start_next_level() -> void:
	if(ability_k1_livingArmor.run):
		print("ability_k1_livingArmor.run")
		timer_ability_k_1_living_armor.start(ability_k1_livingArmor.num)

func fun_end_current_level() -> void:
	if(ability_k1_livingArmor.run):
		print("ability_k1_livingArmor.run.stop() ")
		timer_ability_k_1_living_armor.stop() 


func _ready() -> void:
	timer.wait_time = time_timer


func _physics_process(delta: float) -> void:
	# print("hp_player - ", hp_player)
	# print(ability_k1_livingArmor)
	# меняем анимацию исходя от процента hp
	if (!Global.stop_game):
		if ((hp_start_player / 100) * 100 >= hp_player and (hp_start_player / 100) * 75 < hp_player and not_death):
			#print(hp_player)
			sprite.play("100-75%")
		elif ((hp_start_player / 100) * 75 >= hp_player and (hp_start_player / 100) * 50 < hp_player and not_death):
			#print(hp_player)
			sprite.play("75-50%")
		elif ((hp_start_player / 100) * 50 >= hp_player and (hp_start_player / 100) * 25 < hp_player and not_death):
			#print(hp_player)
			sprite.play("50-25%")
		elif ((hp_start_player / 100) * 25 >= hp_player and (hp_start_player / 100) * 0 < hp_player and not_death):
			#print(hp_player)
			sprite.play("25-0%")
	else:
		sprite.stop()
	

	# если hp у корабля меньше или равен нулю то
	if (hp_player <= 0 and not_death):
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
	if ((position.x <= get_global_mouse_position().x - 15 or position.x >= get_global_mouse_position().x + 15) or (position.y <= get_global_mouse_position().y - 15 or position.y >= get_global_mouse_position().y + 15)) and not_death and !stop and !Global.stop_game:
		# self.global_position +=  self.position.direction_to(get_global_mouse_position())  * 300 * 5 * delta
		self.velocity = self.position.direction_to(get_global_mouse_position()) * speed_ship
		
	else:
		velocity = Vector2(0, 0)



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
	if (stop):
		self.visible = false
	else:
		self.visible = true
	attack_bool = true

	if (hp_player < 0):
		hp_player = 0
	
	if (Global.stop_game):
		timer.paused = true
	else:
		timer.paused = false
	# print(ability_k1_livingArmor)


# сигнал узла timer срабатывает раз в какое-то время
func _on_timer_timeout() -> void:
	if (attack_bool and not_death and !stop):
		var bullet_scene = load("res://ALL_scenes/bullet/bullet.tscn")
		var bullet: CharacterBody2D = bullet_scene.instantiate()
		bullet.global_position = marker.global_position
		bullet.speed = speed_bullet
		bullet.damage_bullet = damage


		var player_shot_sound_scene = load("res://ALL_scenes/player_shot_sound/player_shot_sound.tscn")
		var player_shot_sound = player_shot_sound_scene.instantiate()
		level.add_child(player_shot_sound)


		player_bullets.add_child(bullet)


func _on_timer_ability_k_1_living_armor_timeout() -> void:
	if(hp_start_player > hp_player):
		print("timer run")
		print(hp_player)
		print("+")
		print(ability_k1_livingArmor)
		hp_player += ability_k1_livingArmor.plus_hp
		if(hp_start_player <= hp_player):
			hp_player = hp_start_player
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color("#74FF78"), 0.7)
		# await get_tree().create_timer(0.1).timeout
		tween.tween_property(sprite, "modulate", Color("#FFFFFF"), 0.2)

func universal_indicator_HP_recovery_enemies():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color("#ff70e7"), 0.7)
	tween.tween_property(sprite, "modulate", Color("#FFFFFF"), 0.2)
