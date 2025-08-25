extends Area2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"

# создаём рандомные координаты x
var save_X = randi_range(200,520)

# создаём рандомную скорость вращения 
var save_num_rotation = randf_range(-5, 5)

# создаём рандомную скорость перемещения

var sprite2D:AnimatedSprite2D

var death = false

var hp:float
var damage:float
var speed:float
var name_str = "meteorite"
var enemy_level = 1

@onready var level = $"../.."




func _ready() -> void:
	var scale_num = randf_range(1.6 , 3.0)
	self.scale = Vector2(scale_num  , scale_num)
	sprite2D = $AnimatedSprite2D
	sprite2D.play("meteor " + str(randi_range(1 , 5)))
	
	speed = randf_range(30, 200)
	if(enemy_level == 1):
		damage = scale_num * 50
		hp = scale_num * 60
	elif(enemy_level == 2):
		damage = scale_num * 70
		hp = scale_num * 80
	elif(enemy_level == 3):
		damage = scale_num * 90
		hp = scale_num * 100
	elif(enemy_level == 4):
		damage = scale_num * 110
		hp = scale_num * 120
	elif(enemy_level == 5):
		damage = scale_num * 130
		hp = scale_num * 150
	elif(enemy_level == 6):
		damage = scale_num * 180
		hp = scale_num * 200
	elif(enemy_level == 7):
		damage = scale_num * 230
		hp = scale_num * 250
	elif(enemy_level == 8):
		damage = scale_num * 300
		hp = scale_num * 320
	elif(enemy_level == 9):
		damage = scale_num * 380
		hp = scale_num * 400
	elif(enemy_level >= 10 and enemy_level < 60):
		# var multiplier = (enemy_level)
		damage = scale_num * (enemy_level * 50 - 20)
		hp = scale_num * (enemy_level * 50)




func _process(delta: float) -> void:
	#print(galaxy_ship.position.y)
	
	# метеорит преследует игрока
	#position += self.position.direction_to(galaxy_ship.position) * 300 * delta
	
	# метеорит летит в низ на рандомные координаты по x
	if (!Global.stop_game):
		position += self.position.direction_to(Vector2i(save_X , 1700)) * speed * delta
	
	
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
		
