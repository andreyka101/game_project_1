extends Node2D


var num_level_hard = 1
var num_level_text = 1
var price_level = 50






func _ready() -> void:
	method_level()

	# тип врага 1 - метеорит
	#var meteorite_scene = load("res://ALL_scenes/meteorite/meteorite.tscn")
	#for i in range(10):
		## создаём метеориты в случайных координатах по x
		#var meteorite:Area2D = meteorite_scene.instantiate()
		#meteorite.position = Vector2(randi_range(-200,1580),50)
		#add_child(meteorite)
	
	
	
	
	# тип врага 2 - белый корабль
	# var enemyShip_1_scene = load("res://ALL_scenes/enemyShip_1/enemy_ship_1.tscn")
	# for i in range(10):
	# 	# создаём корабли в случайных координатах по x
	# 	var enemyShip_1:Area2D = enemyShip_1_scene.instantiate()
	# 	# enemyShip_1.position = Vector2(randi_range(-200,1580),50)
	# 	enemyShip_1.position = Vector2(randi_range(0,1380),50)
	# 	add_child(enemyShip_1)

	
	
	
	# тип врага 3 - красный корабль
	# var enemyShip_2_scene = load("res://ALL_scenes/enemyShip_2/enemy_ship_2.tscn")
	# for i in range(10):
	# 	# создаём корабли в случайных координатах по x
	# 	var enemyShip_2:Area2D = enemyShip_2_scene.instantiate()
	# 	enemyShip_2.position = Vector2(randi_range(0,1380),50)
	# 	add_child(enemyShip_2)

	
	
	
	# тип врага 4 - черный корабль
	#var enemyShip_3_scene = load("res://ALL_scenes/enemyShip_3/enemy_ship_3.tscn")
	#for i in range(10):
		## создаём корабли в случайных координатах по x
		#var enemyShip_3:Area2D = enemyShip_3_scene.instantiate()
		#enemyShip_3.position = Vector2(randi_range(0,1380),50)
		#add_child(enemyShip_3)
	
	
	
	
	# тип врага 5 - круглый дрон
	# var drone_1_scene = load("res://ALL_scenes/drone_1/drone_1.tscn")
	# for i in range(10):
	# 	# создаём корабли в случайных координатах по x
	# 	var drone_1:Area2D = drone_1_scene.instantiate()
	# 	drone_1.position = Vector2(randi_range(0,1380),50)
	# 	add_child(drone_1)
	
	
	
	
	# тип врага 6 - желтый дрон
	# var drone_2_scene = load("res://ALL_scenes/drone_2/drone_2.tscn")
	# for i in range(10):
	# 	var drone_2:CharacterBody2D = drone_2_scene.instantiate() 
	# 	drone_2.position = Vector2(randi_range(0,1380),50)
	# 	add_child(drone_2)



func method_level():
	var remainder_price = 6
	var local_price_level = price_level
	while(local_price_level != 0):
		if(local_price_level < remainder_price):
			remainder_price = local_price_level
		# var rund_num = randi_range(1,remainder_price)
		var chance_of_appearance = randi_range(1,100)
		var obj_s = {
			"num 1": 30,
			"num 2": 50,
			"num 3": 70,
			"num 4": 80,
			"num 5": 95,
		}

		if((local_price_level >= 1 and chance_of_appearance < 30) or local_price_level == 1):
			var meteorite_scene = load("res://ALL_scenes/meteorite/meteorite.tscn")
			var meteorite:Area2D = meteorite_scene.instantiate()
			meteorite.position = Vector2(randi_range(-200,1580),50)
			add_child(meteorite)
			local_price_level -= 1
			Global.enemies_released += 1
		if(local_price_level >= 2 and (chance_of_appearance >= 30 and chance_of_appearance < 50)):
			var enemyShip_1_scene = load("res://ALL_scenes/enemyShip_1/enemy_ship_1.tscn")
			var enemyShip_1:Area2D = enemyShip_1_scene.instantiate()
			enemyShip_1.position = Vector2(randi_range(0,1380),50)
			add_child(enemyShip_1)
			local_price_level -= 2
			Global.enemies_released += 1
		if(local_price_level >= 3 and (chance_of_appearance >= 50 and chance_of_appearance < 70)):
			var enemyShip_2_scene = load("res://ALL_scenes/enemyShip_2/enemy_ship_2.tscn")
			var enemyShip_2:Area2D = enemyShip_2_scene.instantiate()
			enemyShip_2.position = Vector2(randi_range(0,1380),50)
			add_child(enemyShip_2)
			local_price_level -= 3
			Global.enemies_released += 1
		if(local_price_level >= 4 and (chance_of_appearance >= 70 and chance_of_appearance < 80)):
			var enemyShip_3_scene = load("res://ALL_scenes/enemyShip_3/enemy_ship_3.tscn")
			var enemyShip_3:Area2D = enemyShip_3_scene.instantiate()
			enemyShip_3.position = Vector2(randi_range(0,1380),50)
			add_child(enemyShip_3)
			local_price_level -= 4
			Global.enemies_released += 1
		if(local_price_level >= 5 and (chance_of_appearance >= 80 and chance_of_appearance < 95)):
			var drone_1_scene = load("res://ALL_scenes/drone_1/drone_1.tscn")
			var drone_1:Area2D = drone_1_scene.instantiate()
			drone_1.position = Vector2(randi_range(0,1380),50)
			add_child(drone_1)
			local_price_level -= 5
			Global.enemies_released += 1
		if(local_price_level >= 6 and (chance_of_appearance >= 95 and chance_of_appearance <= 100)):
			var drone_2_scene = load("res://ALL_scenes/drone_2/drone_2.tscn")
			var drone_2:CharacterBody2D = drone_2_scene.instantiate() 
			drone_2.position = Vector2(randi_range(0,1380),50)
			add_child(drone_2)
			local_price_level -= 6
			Global.enemies_released += 1
	

func _process(delta: float) -> void:
	print(Global.enemies_released)


# обработка нажатий
func _input(event):
	# сворачивание экрана на ESC
	if(event.is_action_pressed("esc_key")):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
