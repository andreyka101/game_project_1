extends Area2D


@onready var galaxy_ship:CharacterBody2D = $"../Galaxy_ship"

# создаём рандомные координаты x
var save_X = randi_range(0,1280)

# создаём рандомную скорость вращения 
var save_num_rotation = randf_range(-5, 5)

# создаём рандомную скорость перемещения
var speed = randf_range(10, 200)

var hp:float
var sprite2D:AnimatedSprite2D





func _ready() -> void:
	#print("start")

	# создаём рандомный размер
	var scale_num = randf_range(0.6 , 2.0)
	# задаём сохранённый размер по ширине и высоте 
	self.scale = Vector2(scale_num  , scale_num)

	# задаём hp относительно размера
	hp = scale_num * 120
	
	sprite2D = $AnimatedSprite2D
	# рандомная анимация
	sprite2D.play("meteor " + str(randi_range(1 , 5)))




func _process(delta: float) -> void:
	#print(galaxy_ship.position.y)
	
	# метеорит преследует игрока
	#position += self.position.direction_to(galaxy_ship.position) * 300 * delta
	
	# метеорит летит в низ на рандомные координаты по x
	position += self.position.direction_to(Vector2i(save_X , 1000)) * speed * delta
	
	
	# вращение метеорита 
	self.rotation_degrees += save_num_rotation
	
	
	if(hp <= 0):
		sprite2D.play("explosion")
		save_num_rotation = 0
		await sprite2D.animation_finished
		self.queue_free()
	


func _on_body_entered(body: Node2D) -> void:
	# возвращает вошедшие группы
	#print(body.get_groups())
	#print(body.name)
	
	
	if(body.name == "Galaxy_ship"):
		#print("ok if")
		
		body.hp_player -= 300
		sprite2D.play("explosion")
		await sprite2D.animation_finished
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
			
			
			# смерть метеорита 
			if(hp <= 0):
				sprite2D.play("explosion")
				save_num_rotation = 0
				await sprite2D.animation_finished
				self.queue_free()
		
