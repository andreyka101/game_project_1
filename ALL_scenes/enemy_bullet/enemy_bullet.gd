extends Area2D


var sideways_movement = false
var position_save = null



var damage_bullet = 100
var speed_bullet = 400




func  _ready() -> void:
	# если пуля должка двигаться в бок то поворачиваем sprite на 90 градусов
	if(sideways_movement):
		$AnimatedSprite2D.rotation_degrees = 90




func _physics_process(delta: float) -> void:
	
	
	# проверка как должка двигаться пуля прямо или в бок
	# print(name , global_position)
	if(sideways_movement):
		# линейное движение до какой-то точки
		self.position += self.position.direction_to(position_save) * speed_bullet * delta
		
		# пуля смотрит на какую-то точку
		look_at(position_save)
	else:
		
		self.position.y += speed_bullet * delta
	
	
	
	

	# если пуля улетела слишком далеко за экран то уделяем её 
	if(self.position.y > 850):
		queue_free()



# наносим урон игроку при вхождении
func _on_body_entered(body: Node2D) -> void:
		if(body.name == "Galaxy_ship"):
		
			body.hp_player -= 30
			self.queue_free()
