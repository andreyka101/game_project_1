extends CharacterBody2D


var damage_bullet = 150

@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"


func _physics_process(delta: float) -> void:
	# постоянная скорость пули
	if (!Global.stop_game):
		self.position.y -= 600 * delta
	#self.velocity.y = -300
	if (Global.stop_game):
		sprite2D.stop()
	
	
	
	# если пуля улетела слишком далеко за экран то уделяем её 
	if(self.position.y < -100):
		queue_free()
	
	
	#self.move_and_slide()
