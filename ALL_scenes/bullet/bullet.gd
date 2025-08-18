extends CharacterBody2D


var damage_bullet = 0

@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"

var speed = 0
var name_str = "player bullet"


func _physics_process(delta: float) -> void:
	# постоянная скорость пули
	if (!Global.stop_game):
		self.position.y -= speed * delta
	#self.velocity.y = -300
	if (Global.stop_game):
		sprite2D.stop()
	else:
		sprite2D.play_backwards()
	
	
	
	# если пуля улетела слишком далеко за экран то уделяем её 
	if(self.position.y < -100):
		queue_free()
	
	
	#self.move_and_slide()
