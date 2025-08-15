extends Area2D



var death = true
@onready var level = $".."
@onready var timer:Timer = $Timer
@onready var marker:Marker2D = $Marker2D
@onready var marker_LEFT:Marker2D = $Marker2D_LEFT
@onready var marker_RIGHT:Marker2D = $Marker2D_RIGHT
@onready var timer_position:Timer = $Timer_position
var hp = 300
@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"
@onready var bullets_of_enemies:Node2D = $"../../Bullets_of_enemies"

var position_save = Vector2(randi_range(10 , 710) , randi_range(10 , 600))

var damage = 70
var name_str = "double ship"


func _ready() -> void:
	# меняет время срабатывания таймера
	#timer.wait_time = randf_range(1 , 3)

	# запускаем и меняет время срабатывания таймера
	timer.start(randf_range(1 , 3))
	
	
	timer_position.start(randf_range(7 , 15))
	
	

func _physics_process(delta: float) -> void:
	if(Global.stop_game):
		timer.paused = true
		timer_position.paused = true
	else:
		timer.paused = false
		timer_position.paused = false

	# движение корабля
	if((position.x <= position_save.x - 15 or position.x >= position_save.x + 15) or (position.y <= position_save.y - 15 or position.y >= position_save.y + 15)) and death and !Global.stop_game:
		self.position += self.position.direction_to(position_save) * 100 * delta
	
	if(hp <= 0 and death):
		death = false
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		$"../../AudioStreamPlayer2D2".playing = true
		self.queue_free()
	# if (Global.stop_game):
	# 	sprite2D.stop()
	



# создаем пулю раз в какое-то время
func _on_timer_timeout() -> void:
	#print("on_timer_timeout")
	if(death and !Global.stop_game):
		# создаём две пули которые будут лететь в бок
		var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
		# пуля 1 ------------
		var bullet_LEFT:Area2D = bullet_scene.instantiate()
		bullet_LEFT.global_position = marker.global_position
		bullet_LEFT.position_save = marker_LEFT.global_position
		bullet_LEFT.sideways_movement = true
		bullets_of_enemies.add_child(bullet_LEFT)
		# пуля 2 ------------
		var bullet_RIGHT:Area2D = bullet_scene.instantiate()
		bullet_RIGHT.global_position = marker.global_position
		bullet_RIGHT.position_save = marker_RIGHT.global_position
		bullet_RIGHT.sideways_movement = true
		bullets_of_enemies.add_child(bullet_RIGHT)


		# таймер будет срабатывать в случайное время
	timer.wait_time = randf_range(1 , 3)


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Galaxy_ship" and death):
		death = true
		body.hp_player -= damage
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		$"../../AudioStreamPlayer2D2".playing = true
		self.queue_free()
	for i_group in body.get_groups():
		#print(i_group)
		# если в группе есть пуля то наносим урон кораблю и удаляем пулю
		if(i_group == "group_bullet"):
			hp -= body.damage_bullet
			body.queue_free()
			if(hp > 0):
				sprite2D.self_modulate = "#ff4551"
				await get_tree().create_timer(0.2).timeout
				sprite2D.self_modulate = "#fff"
			
			
			# смерть корабля
			if(hp <= 0 and death):
				death = false
				sprite2D.play("explosion")
				await sprite2D.animation_finished
				$"../../AudioStreamPlayer2D2".playing = true
				self.queue_free()


# раз в какое-то время корабль меняет своё направление
func _on_timer_position_timeout() -> void:
	if (!Global.stop_game):
		position_save = Vector2(randi_range(10 , 710) , randi_range(10 , 600))
		# меняем время срабатывания этого таймера
	timer_position.wait_time = randf_range(7 , 15)
