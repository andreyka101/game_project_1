extends Area2D


var death = true
@onready var level = $".."
@onready var timer:Timer = $Timer
@onready var marker:Marker2D = $Marker2D
@onready var timer_position:Timer = $Timer_position
var hp = 300
@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"

var position_save = Vector2(randi_range(10 , 1270) , randi_range(10 , 350))



func _ready() -> void:
	# меняет время срабатывания таймера
	#timer.wait_time = randf_range(1 , 3)

	# запускаем и меняет время срабатывания таймера
	timer.start(randf_range(1 , 3))
	
	
	timer_position.start(randf_range(7 , 15))
	
	

func _physics_process(delta: float) -> void:
	# движение корабля
	if((position.x <= position_save.x - 15 or position.x >= position_save.x + 15) or (position.y <= position_save.y - 15 or position.y >= position_save.y + 15)) and death:
		self.position += self.position.direction_to(position_save) * 100 * delta
	



# создаем пулю раз в какое-то время
func _on_timer_timeout() -> void:
	#print("on_timer_timeout")
	if(death):
		var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
		var bullet:Area2D = bullet_scene.instantiate()
		bullet.global_position = marker.global_position
		level.add_child(bullet)
		# таймер будет срабатывать в случайное время
		timer.wait_time = randf_range(1 , 3)


func _on_body_entered(body: Node2D) -> void:
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
			if(hp <= 0):
				death = false
				sprite2D.play("explosion")
				await sprite2D.animation_finished
				self.queue_free()


# раз в какое-то время корабль меняет своё направление
func _on_timer_position_timeout() -> void:
	position_save = Vector2(randi_range(10 , 1270) , randi_range(10 , 350))
	# меняем время срабатывания этого таймера
	timer_position.wait_time = randf_range(7 , 15)
