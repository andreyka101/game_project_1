extends Node2D


var num_level_hard = 1
var num_level_text = 1
var price_level = 3
var start_price_level = 3
var end_level = false

@onready var enemies:Node2D = $Enemies
@onready var bullets_of_enemies: Node2D = $Bullets_of_enemies
@onready var player_bullets: Node2D = $Player_bullets
@onready var label_text_level:Label = $Label_text_level
@onready var label_text_hp:Label = $Label_text_hp
@onready var galaxy_ship:CharacterBody2D = $Galaxy_ship
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $All_audio/AudioEnd_level
var meteorite_scene = load("res://ALL_scenes/meteorite/meteorite.tscn")
var enemyShip_White_scene = load("res://ALL_scenes/enemyShip_1/enemy_ship_1.tscn")
var enemyShip_Red_scene = load("res://ALL_scenes/enemyShip_2/enemy_ship_2.tscn")
var enemyShip_Black_scene = load("res://ALL_scenes/enemyShip_3/enemy_ship_3.tscn")
var drone_Violet_scene = load("res://ALL_scenes/drone_1/drone_1.tscn")
var drone_Уellow_scene = load("res://ALL_scenes/drone_2/drone_2.tscn")


# func _ready() -> void:
	# print(start_price_level / 50)

	# method_level()
	# await get_tree().create_timer(2).timeout
	# for i in range(10):
		# creatingEnemies_meteorite()
		# creatingEnemies_enemy_ship_White()
		# creatingEnemies_enemy_ship_Red()
		# creatingEnemies_enemy_ship_Black()
		# creatingEnemies_drone_Violet()
		# creatingEnemies_drone_Уellow()

func creatingEnemies_meteorite():
	if(price_level >= 1):
		var meteorite:Area2D = meteorite_scene.instantiate()
		meteorite.position = Vector2(randi_range(-100,820),-90)
		meteorite.enemy_level = 1
		# meteorite.super_enemy = true
		price_level -= 1
		enemies.add_child(meteorite)
func creatingEnemies_enemy_ship_White():
	if(price_level >= 2):
		var enemyShip_1:Area2D = enemyShip_White_scene.instantiate()
		enemyShip_1.position = Vector2(randi_range(0,720),-50)
		enemyShip_1.enemy_level = 1
		# enemyShip_1.super_enemy = true
		price_level -= 2
		enemies.add_child(enemyShip_1)
func creatingEnemies_enemy_ship_Red():
	if(price_level >= 2):
		var enemyShip_2:Area2D = enemyShip_Red_scene.instantiate()
		enemyShip_2.position = Vector2(randi_range(0,720),-50)
		enemyShip_2.enemy_level = 1
		# enemyShip_2.super_enemy = true
		price_level -= 2
		enemies.add_child(enemyShip_2)
func creatingEnemies_enemy_ship_Black():
	if(price_level >= 3):
		var enemyShip_3:Area2D = enemyShip_Black_scene.instantiate()
		enemyShip_3.position = Vector2(randi_range(0,720),-50)
		enemyShip_3.enemy_level = 1
		# enemyShip_3.super_enemy = true
		price_level -= 3
		enemies.add_child(enemyShip_3)
func creatingEnemies_drone_Violet():
	if(price_level >= 1):
		var drone_1:Area2D = drone_Violet_scene.instantiate()
		drone_1.position = Vector2(randi_range(200,920),-10)
		drone_1.enemy_level = 1
		# drone_1.super_enemy = true
		price_level -= 1
		enemies.add_child(drone_1)
func creatingEnemies_drone_Уellow():
	if(price_level >= 3):
		var drone_2:CharacterBody2D = drone_Уellow_scene.instantiate() 
		drone_2.position = Vector2(randi_range(0,720),-150)
		drone_2.enemy_level = 1
		# drone_2.super_enemy = true
		price_level -= 3
		enemies.add_child(drone_2)





func _process(delta: float) -> void:
	# print(25%10)
	
	label_text_level.text = "level " + str(num_level_text)
	if(galaxy_ship):
		label_text_hp.text = "hp " + str(int(galaxy_ship.hp_player))
	else:
		get_tree().change_scene_to_file("res://ALL_scenes/main_menu/main_menu.tscn")

	if(len(enemies.get_children()) == 0 and !end_level and price_level == 0):
		end_level = true
		for child in bullets_of_enemies.get_children():
			child.queue_free()
		for child in player_bullets.get_children():
			child.queue_free()
		galaxy_ship.position = Vector2(360,1050)
		galaxy_ship.stop = true
		$Button.visible = true
		galaxy_ship.hp_player = galaxy_ship.hp_start_player
		$ParallaxBackground_var_1.speed = 3
		audio_stream_player_2d.playing = true
		# print(audio_stream_player_2d)
	elif(len(enemies.get_children()) <= 1 and price_level != 0):
		method_level()



func _on_button_pressed() -> void:
	end_level = false
	num_level_text += 1
	num_level_hard += 1
	if((num_level_hard % 100) >= 1 and (num_level_hard % 100) < 6):
		if((num_level_hard % 100) >= 1 and (num_level_hard % 100) < 4):
			start_price_level += 3
		else:
			start_price_level += 1
	elif((num_level_hard % 100) >= 6 and (num_level_hard % 100) < 12):
		if((num_level_hard % 100) >= 6 and (num_level_hard % 100) < 9):
			start_price_level += 3
	price_level = start_price_level
	galaxy_ship.stop = false
	$Button.visible = false
	$ParallaxBackground_var_1.speed = 15
	method_level()


# обработка нажатий
func _input(event):
	# сворачивание экрана на ESC
	if(event.is_action_pressed("esc_key")):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)







func method_level():
	var number_enemies_on_wave
	if((num_level_hard / 100)+1 >= 1 and (num_level_hard / 100)+1 < 5):
		number_enemies_on_wave = 3
	elif((num_level_hard / 100)+1 >= 5 and (num_level_hard / 100)+1 < 20):
		number_enemies_on_wave = 4
	# elif((num_level_hard / 100)+1 >= 10 and (num_level_hard / 100)+1 < 15):
	# 	number_enemies_on_wave = randi_range(4,5)
	# elif((num_level_hard / 100)+1 >= 15 and (num_level_hard / 100)+1 < 20):
	# 	number_enemies_on_wave = randi_range(5,7)
	# elif((num_level_hard / 100)+1 >= 20 and (num_level_hard / 100)+1 < 40):
	# 	number_enemies_on_wave = randi_range(5,8)
	# elif((num_level_hard / 100)+1 >= 40 and (num_level_hard / 100)+1 < 60):
	# 	number_enemies_on_wave = randi_range(6,9)
	# elif((num_level_hard / 100)+1 >= 60 and (num_level_hard / 100)+1 < 80):
	# 	number_enemies_on_wave = randi_range(7,11)
	# elif((num_level_hard / 100)+1 >= 60 and (num_level_hard / 100)+1 < 80):
	# 	number_enemies_on_wave = randi_range(8,13)
	# elif((num_level_hard / 100)+1 >= 80):
	# 	number_enemies_on_wave = randi_range(9,15)


	while(price_level != 0 and number_enemies_on_wave != 0):

		if((num_level_hard % 100) == 1):
			number_enemies_on_wave -= 1
			creatingEnemies_meteorite()

		elif((num_level_hard % 100) == 2):
			number_enemies_on_wave -= 1
			creatingEnemies_meteorite()

		elif((num_level_hard % 100) == 3):
			if(randi_range(0 , 100) <= 95 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()

		elif((num_level_hard % 100) == 4):
			if(randi_range(0 , 100) <= 70 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()

		elif((num_level_hard % 100) == 5):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()

		elif((num_level_hard % 100) == 6):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()

		elif((num_level_hard % 100) == 7):
			if(randi_range(0 , 100) <= 70 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()

		elif((num_level_hard % 100) == 8):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()

		elif((num_level_hard % 100) == 9):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			elif(randi_range(0 , 100) <= 60):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()

		elif((num_level_hard % 100) == 10):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			elif(randi_range(0 , 100) <= 30):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()

		elif((num_level_hard % 100) == 11):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()

		# elif((num_level_hard % 100) == 11):
		# 	if(randi_range(0 , 100) <= 10 or price_level == 1):
		# 		number_enemies_on_wave -= 1
		# 		creatingEnemies_meteorite()
		# 	else:
		# 		number_enemies_on_wave -= 1
		# 		creatingEnemies_enemy_ship_Red()




	
