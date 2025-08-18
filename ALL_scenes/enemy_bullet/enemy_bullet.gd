extends Area2D


var sideways_movement = false
var position_save = null



var damage_bullet = 20
var speed_bullet = 400

var name_str = "enemy bullet"


@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"



func  _ready() -> void:
	# если пуля должка двигаться в бок то поворачиваем sprite на 90 градусов
	if(sideways_movement):
		$AnimatedSprite2D.rotation_degrees = 90




func _physics_process(delta: float) -> void:
	# if (Global.stop_game):
	# 	sprite2D.stop()
	
	
	# проверка как должка двигаться пуля прямо или в бок
	# print(name , global_position)
	if (!Global.stop_game):
		if(sideways_movement):
			# линейное движение до какой-то точки
			self.position += self.position.direction_to(position_save) * speed_bullet * delta
			
			# пуля смотрит на какую-то точку
			look_at(position_save)
		else:
			
			self.position.y += speed_bullet * delta
	
	
	
	

	# если пуля улетела слишком далеко за экран то уделяем её 
	if(self.position.y > 1700):
		queue_free()



# наносим урон игроку при вхождении
func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Galaxy_ship"):
	
		body.hp_player -= damage_bullet
		self.queue_free()
		


func _on_area_entered(area: Node2D) -> void:
	print(area.name)
	print(area.name_str)
	if(area.name_str == "meteorite"):
		self.queue_free()
