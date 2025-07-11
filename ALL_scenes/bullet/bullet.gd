extends CharacterBody2D


var damage_bullet = 100


func _physics_process(delta: float) -> void:
	# постоянная скорость пули
	self.position.y -= 400 * delta
	#self.velocity.y = -300
	
	
	
	# если пуля улетела слишком далеко за экран то уделяем её 
	if(self.position.y < -100):
		queue_free()
	
	
	#self.move_and_slide()
