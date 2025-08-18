extends Area2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"

# создаём рандомные координаты x
var save_X = randi_range(200,520)

# создаём рандомную скорость вращения 
var save_num_rotation = randf_range(-5, 5)

# создаём рандомную скорость перемещения
var speed = randf_range(30, 200)

var hp:float
var sprite2D:AnimatedSprite2D

var death = false

var damage:int
var name_str = "meteorite"
var audio_boom:AudioStreamPlayer2D





func _ready() -> void:
	#print("start")

	# создаём рандомный размер
	var scale_num = randf_range(1.6 , 3.0)
	damage = scale_num * 20
	# задаём сохранённый размер по ширине и высоте 
	self.scale = Vector2(scale_num  , scale_num)

	# задаём hp относительно размера
	hp = scale_num * 120
	
	sprite2D = $AnimatedSprite2D
	# рандомная анимация
	sprite2D.play("meteor " + str(randi_range(1 , 5)))

	audio_boom = get_node("../../All_audio/Enemy_explosion_sound/AudioBoom_%s" % (randi_range(1,11)))




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
		audio_boom.playing = true
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
		audio_boom.playing = true
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
			if(hp <= 0 and !death):
				death = true
				sprite2D.play("explosion")
				save_num_rotation = 0
				await sprite2D.animation_finished
				audio_boom.playing = true
				self.queue_free()
		
