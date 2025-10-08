extends Node2D


# var num_level_hard = 1
# var num_level_text = 1
# var price_level = 3
# var start_price_level = 3
var num_level_hard = 25
var num_level_text = 25
var price_level = 17
var start_price_level = 17
var end_level = false

@onready var enemies:Node2D = $Enemies
@onready var bullets_of_enemies: Node2D = $Bullets_of_enemies
@onready var player_bullets: Node2D = $Player_bullets
@onready var label_text_level:Label = $Label_text_level
@onready var label_text_hp:Label = $Label_text_hp
@onready var label_dps: Label = $Menu_button/Settings_level/Label_dps
@onready var galaxy_ship:CharacterBody2D = $Galaxy_ship
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $All_audio/AudioEnd_level
var meteorite_scene = load("res://ALL_scenes/meteorite/meteorite.tscn")
var enemyShip_White_scene = load("res://ALL_scenes/enemyShip_1/enemy_ship_1.tscn")
var enemyShip_Red_scene = load("res://ALL_scenes/enemyShip_2/enemy_ship_2.tscn")
var enemyShip_Black_scene = load("res://ALL_scenes/enemyShip_3/enemy_ship_3.tscn")
var drone_Violet_scene = load("res://ALL_scenes/drone_1/drone_1.tscn")
var drone_Уellow_scene = load("res://ALL_scenes/drone_2/drone_2.tscn")
var arr_enemies = []


func _ready() -> void:
	# print(start_price_level / 50)
	# print(1 / 1,"-+-++--++-")
	label_dps.text = "DPS = " + str(round(((1 / galaxy_ship.time_timer) * galaxy_ship.damage) * 10 * 100) / 100.0)
	# label_dps.text = "DPS = " str((1 / galaxy_ship.time_timer) * galaxy_ship.damage)
	# method_level()
	# await get_tree().create_timer(2).timeout
	# for i in range(1):
	# 	creatingEnemies_meteorite()
		# creatingEnemies_enemy_ship_White(1)
		# creatingEnemies_enemy_ship_Red(2)
		# creatingEnemies_enemy_ship_Black(1)
		# creatingEnemies_drone_Violet(2)
		# creatingEnemies_drone_Уellow(2)
	# for enemy in arr_enemies:
	# 	enemies.add_child(enemy)

func creatingEnemies_meteorite(enemy_difficulty = 0):
	if(price_level >= 1):
		var meteorite:Area2D = meteorite_scene.instantiate()
		meteorite.position = Vector2(randi_range(-100,820),-90)
		meteorite.enemy_level = 1
		if(enemy_difficulty == 0):
			meteorite.super_enemy = false
		elif(enemy_difficulty == 1):
			meteorite.super_enemy = true
		elif(enemy_difficulty == 2):
			meteorite.mega_enemy = true
		price_level -= 1
		arr_enemies.append(meteorite)
		# enemies.add_child(meteorite)
func creatingEnemies_enemy_ship_White(enemy_difficulty = 0):
	if(price_level >= 2):
		var enemyShip_1:Area2D = enemyShip_White_scene.instantiate()
		enemyShip_1.position = Vector2(randi_range(0,720),-50)
		enemyShip_1.enemy_level = 1
		if(enemy_difficulty == 0):
			enemyShip_1.super_enemy = false
		if(enemy_difficulty == 1):
			enemyShip_1.super_enemy = true
		if(enemy_difficulty == 2):
			enemyShip_1.mega_enemy = true
		price_level -= 2
		arr_enemies.append(enemyShip_1)
		# enemies.add_child(enemyShip_1)
func creatingEnemies_enemy_ship_Red(enemy_difficulty = 0):
	if(price_level >= 2):
		var enemyShip_2:Area2D = enemyShip_Red_scene.instantiate()
		enemyShip_2.position = Vector2(randi_range(0,720),-50)
		enemyShip_2.enemy_level = 1
		if(enemy_difficulty == 0):
			enemyShip_2.super_enemy = false
		if(enemy_difficulty == 1):
			enemyShip_2.super_enemy = true
		if(enemy_difficulty == 2):
			enemyShip_2.mega_enemy = true
		price_level -= 2
		arr_enemies.append(enemyShip_2)
		# enemies.add_child(enemyShip_2)
func creatingEnemies_enemy_ship_Black(enemy_difficulty = 0):
	if(price_level >= 3):
		var enemyShip_3:Area2D = enemyShip_Black_scene.instantiate()
		enemyShip_3.position = Vector2(randi_range(0,720),-50)
		enemyShip_3.enemy_level = 1
		if(enemy_difficulty == 0):
			enemyShip_3.super_enemy = false
		if(enemy_difficulty == 1):
			enemyShip_3.super_enemy = true
		if(enemy_difficulty == 2):
			enemyShip_3.mega_enemy = true
		price_level -= 3
		arr_enemies.append(enemyShip_3)
		# enemies.add_child(enemyShip_3)
func creatingEnemies_drone_Violet(enemy_difficulty = 0):
	if(price_level >= 1):
		var drone_1:Area2D = drone_Violet_scene.instantiate()
		drone_1.position = Vector2(randi_range(200,920),-10)
		drone_1.enemy_level = 1
		if(enemy_difficulty == 0):
			drone_1.super_enemy = false
		if(enemy_difficulty == 1):
			drone_1.super_enemy = true
		if(enemy_difficulty == 2):
			drone_1.mega_enemy = true
		price_level -= 1
		arr_enemies.append(drone_1)
		# enemies.add_child(drone_1)
func creatingEnemies_drone_Уellow(enemy_difficulty = 0):
	if(price_level >= 2):
		var drone_2:CharacterBody2D = drone_Уellow_scene.instantiate() 
		drone_2.position = Vector2(randi_range(0,720),-150)
		drone_2.enemy_level = 1
		if(enemy_difficulty == 0):
			drone_2.super_enemy = false
		if(enemy_difficulty == 1):
			drone_2.super_enemy = true
		if(enemy_difficulty == 2):
			drone_2.mega_enemy = true
		price_level -= 2
		arr_enemies.append(drone_2)
		# enemies.add_child(drone_2)





func _process(delta: float) -> void:
	# print(price_level)
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
	elif(len(enemies.get_children()) <= 1 and price_level != 0 and ((num_level_hard % 100)>=1 and (num_level_hard % 100)<23)):
		method_level()
	elif(len(enemies.get_children()) <= 2 and price_level != 0 and ((num_level_hard % 100)>=23 and (num_level_hard % 100)<50)):
		method_level()



func _on_button_pressed() -> void:
	end_level = false
	num_level_text += 1
	num_level_hard += 1
	galaxy_ship.stop = false
	$Button.visible = false
	$ParallaxBackground_var_1.speed = 15

	if((num_level_hard % 100) >= 1 and (num_level_hard % 100) < 4):
		start_price_level += 2
	elif((num_level_hard % 100) == 7):
			start_price_level += 3
	elif((num_level_hard % 100) == 10):
			start_price_level += 3
	elif((num_level_hard % 100) == 13):
			start_price_level += 3
	elif((num_level_hard % 100) == 15):
			start_price_level = round(start_price_level / 1.5)
	elif((num_level_hard % 100) == 23):
			start_price_level = round(start_price_level * 1.5)
	elif((num_level_hard % 100) == 26 or (num_level_hard % 100) == 28 or (num_level_hard % 100) == 30 or (num_level_hard % 100) == 34 or (num_level_hard % 100) == 38):
			start_price_level += 4
	# elif((num_level_hard % 100) == 28):
	# 		start_price_level += 4
	# elif((num_level_hard % 100) == 30):
	# 		start_price_level += 4
	price_level = start_price_level
	method_level()
	print(num_level_hard,"--=--=--=--")
	print(start_price_level)







func method_level():
	var number_enemies_on_wave
	if((num_level_hard % 100) >= 1 and (num_level_hard % 100) < 10):
		number_enemies_on_wave = 3
	elif((num_level_hard % 100) >= 10 and (num_level_hard % 100) < 15):
		number_enemies_on_wave = 4
	elif((num_level_hard % 100) >= 15 and (num_level_hard % 100) < 40):
		number_enemies_on_wave = randi_range(4,5)
	# elif((num_level_hard % 100) >= 10 and (num_level_hard % 100) < 15):
	# 	number_enemies_on_wave = randi_range(4,5)
	# elif((num_level_hard % 100) >= 15 and (num_level_hard % 100) < 20):
	# 	number_enemies_on_wave = randi_range(5,7)
	# elif((num_level_hard % 100) >= 20 and (num_level_hard % 100) < 40):
	# 	number_enemies_on_wave = randi_range(5,8)
	# elif((num_level_hard % 100) >= 40 and (num_level_hard % 100) < 60):
	# 	number_enemies_on_wave = randi_range(6,9)
	# elif((num_level_hard % 100) >= 60 and (num_level_hard % 100) < 80):
	# 	number_enemies_on_wave = randi_range(7,11)
	# elif((num_level_hard % 100) >= 60 and (num_level_hard % 100) < 80):
	# 	number_enemies_on_wave = randi_range(8,13)
	# elif((num_level_hard % 100) >= 80):
	# 	number_enemies_on_wave = randi_range(9,15)

	# print(start_price_level)
	while(price_level != 0 and number_enemies_on_wave != 0):
		# print(number_enemies_on_wave)
		# 3
		if((num_level_hard % 100) == 1):
			number_enemies_on_wave -= 1
			creatingEnemies_meteorite()
		# 5
		elif((num_level_hard % 100) == 2):
			number_enemies_on_wave -= 1
			creatingEnemies_meteorite()
		# 7
		elif((num_level_hard % 100) == 3):
			if(randi_range(0 , 100) <= 95 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
		# 7
		elif((num_level_hard % 100) == 4):
			if(randi_range(0 , 100) <= 70 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
		# 7
		elif((num_level_hard % 100) == 5):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
		# 7
		elif((num_level_hard % 100) == 6):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
		# 10
		elif((num_level_hard % 100) == 7):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
		# 10
		elif((num_level_hard % 100) == 8):
			if(randi_range(0 , 100) <= 70 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 10
		elif((num_level_hard % 100) == 9):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 13
		elif((num_level_hard % 100) == 10):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 13
		elif((num_level_hard % 100) == 11):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			elif(randi_range(0 , 100) <= 60):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 13
		elif((num_level_hard % 100) == 12):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			elif(randi_range(0 , 100) <= 30):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 16
		elif((num_level_hard % 100) == 13):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			elif(randi_range(0 , 100) <= 30):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 16
		elif((num_level_hard % 100) == 14):
			if(randi_range(0 , 100) <= 10 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
		# 11
		elif((num_level_hard % 100) == 15):
			if(randi_range(0 , 100) <= 75 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
		# 11
		elif((num_level_hard % 100) == 16):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
		# 11
		elif((num_level_hard % 100) == 17):
			if(randi_range(0 , 100) <= 25 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
		# 11
		elif((num_level_hard % 100) == 18):
			if(randi_range(0 , 100) <= 75 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet(1)
		# 11
		elif((num_level_hard % 100) == 19):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet(1)
		# 11
		elif((num_level_hard % 100) == 20):
			if(randi_range(0 , 100) <= 25 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet(1)
		# 11
		elif((num_level_hard % 100) == 21):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite(1)
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
		# 11
		elif((num_level_hard % 100) == 21):
			if(randi_range(0 , 100) <= 75 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite(1)
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
		# 11
		elif((num_level_hard % 100) == 22):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1,2) == 1):
					creatingEnemies_meteorite(1)
				else:
					creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				if(randi_range(1,2) == 1):
					creatingEnemies_drone_Violet(1)
				else:
					creatingEnemies_drone_Violet()
		# 17
		elif((num_level_hard % 100) == 23):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1,2) == 1):
					creatingEnemies_meteorite(1)
				else:
					creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				if(randi_range(1,2) == 1):
					creatingEnemies_drone_Violet(1)
				else:
					creatingEnemies_drone_Violet()
		# 17
		elif((num_level_hard % 100) == 24):
			if(randi_range(0 , 100) <= 50 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1,3) == 1):
					creatingEnemies_meteorite()
				else:
					creatingEnemies_meteorite(1)
			else:
				number_enemies_on_wave -= 1
				if(randi_range(1,3) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_drone_Violet(1)
		# 17
		elif((num_level_hard % 100) == 25):
			if(randi_range(0 , 100) <= 80 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 21
		elif((num_level_hard % 100) == 26):
			if(randi_range(0 , 100) <= 60 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 20):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 21
		elif((num_level_hard % 100) == 27):
			if(randi_range(0 , 100) <= 60 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 20):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 25
		elif((num_level_hard % 100) == 28):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 40):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 25
		elif((num_level_hard % 100) == 29):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 40):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 29
		elif((num_level_hard % 100) == 30):
			if(randi_range(0 , 100) <= 20 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 60):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 29
		elif((num_level_hard % 100) == 31):
			if(randi_range(0 , 100) <= 20 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 60):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 29
		elif((num_level_hard % 100) == 32):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1 ,4) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 20):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 29
		elif((num_level_hard % 100) == 33):
			if(randi_range(0 , 100) <= 40 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1 ,4) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 20):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 33
		elif((num_level_hard % 100) == 34):
			if(randi_range(0 , 100) <= 20 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1 ,4) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 30):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_White()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 33
		elif((num_level_hard % 100) == 35):
			if(randi_range(0 , 100) <= 20 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1 ,4) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_meteorite()
			if(randi_range(0 , 100) <= 30):
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Red()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 33
		elif((num_level_hard % 100) == 36):
			if(randi_range(0 , 100) <= 30 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 33
		elif((num_level_hard % 100) == 37):
			if(randi_range(0 , 100) <= 30 or price_level == 1):
				number_enemies_on_wave -= 1
				if(randi_range(1 ,4) == 1):
					creatingEnemies_drone_Violet()
				else:
					creatingEnemies_meteorite()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()
		# 37 
		elif((num_level_hard % 100) == 38):
			if(randi_range(0 , 100) <= 5 or price_level == 1):
				number_enemies_on_wave -= 1
				creatingEnemies_drone_Violet()
			else:
				number_enemies_on_wave -= 1
				creatingEnemies_enemy_ship_Black()


	for enemy in arr_enemies:
		enemies.add_child(enemy)
	arr_enemies = []


	
