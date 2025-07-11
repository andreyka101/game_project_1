extends CharacterBody2D


@onready var level = $".."
@onready var marker:Marker2D = $"./Marker2D"
var attack_bool:bool = false
var hp_player = 300
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
var not_death = true
#var damage = false

var hp_start_player = 300
# 250


func  _physics_process(delta: float) -> void:
	#print(hp_player)
	
	
	# меняем анимацию исходя от процента hp
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
	

	# если hp у корабля меньше или равен нулю то
	if(hp_player <= 0 and not_death):
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
	if((position.x <= get_global_mouse_position().x - 15 or position.x >= get_global_mouse_position().x + 15) or (position.y <= get_global_mouse_position().y - 15 or position.y >= get_global_mouse_position().y + 15)) and not_death:
		if((get_global_mouse_position().x >0 and get_global_mouse_position().x < 1280 and get_global_mouse_position().y < 700 and get_global_mouse_position().y > 530) or (global_position.x >30 and global_position.x < 1250 and global_position.y < 680 and global_position.y > 480)):
			self.global_position +=  self.position.direction_to(get_global_mouse_position()) * 500 * delta
		else:
			if(get_global_mouse_position() > self.global_position and self.global_position.x >30 and self.global_position.x < 1250):
				self.global_position.x += 500 * delta
			if(get_global_mouse_position() < self.global_position and self.global_position.x >30 and self.global_position.x < 1250):
				self.global_position.x -= 500 * delta




func _process(delta: float):
	# включение / выключение атаки
	#if(Input.is_action_just_pressed("attack")):
		#attack_bool = true
	#if(Input.is_action_just_released("attack")):
		#attack_bool = false
		
		
	attack_bool = true



# сигнал узла timer срабатывает раз в какое-то время
func _on_timer_timeout() -> void:
	#print("ok timer")

	if(attack_bool and not_death):
		# load() - загружает сцену в переменную
		var bullet_scene = load("res://ALL_scenes/bullet/bullet.tscn")
		# .instantiate() - инициализирует сцену как узел (это нужно для дальнейшего использования)
		var bullet:CharacterBody2D = bullet_scene.instantiate()
		#add_child(bullet)
		
		#bullet.position.x = 500
		#bullet.position.y = 500
		
		bullet.global_position  = marker.global_position 

		# add_child() - добавляет дочерний узел к этой сцене
		# add_child(bullet)

		# .add_child() - добавляет дочерний узел к узлу или к другой сцене
		level.add_child(bullet)



		
