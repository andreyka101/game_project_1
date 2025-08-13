extends CharacterBody2D


@onready var galaxy_ship:CharacterBody2D = $"../../Galaxy_ship"
@onready var timer:Timer = $Timer
@onready var marker_RIGHT:Marker2D = $Marker2D_RIGHT
@onready var marker_LEFT:Marker2D = $Marker2D_LEFT
@onready var level = $".."
var hp = 100
@onready var sprite2D:AnimatedSprite2D = $"AnimatedSprite2D"
@onready var collisionPolygon:CollisionPolygon2D = $CollisionPolygon2D

var distance_from_player_X = null
var direction = null
var death = false
var shooting = false
var speed = 200


func _ready() -> void:
	# меняет время срабатывания таймера
	#timer.wait_time = randf_range(1 , 3)

	# запускаем и меняет время срабатывания таймера
	timer.start(randf_range(1 , 2))


func _physics_process(delta: float) -> void:
	if (Global.stop_game):
		sprite2D.stop()


	# print(velocity)
	if(not shooting and galaxy_ship and !death):
		if(galaxy_ship.position and !Global.stop_game and (position.x <= galaxy_ship.position.x - 15 or position.x >= galaxy_ship.position.x + 15)):
			if(galaxy_ship.position.x - self.position.x > 0):
				self.velocity.x = speed
			else:
				self.velocity.x = -speed
		else:
			self.velocity.x = 0
		velocity.y = 75

		

		if(hp <= 0 and !death):
			death = true
			collisionPolygon.visible = false
			sprite2D.play("explosion")
			await sprite2D.animation_finished
			Global.enemies_released -= 1
			if(Global.enemies_released == 0):
				Global.enemies_released = null
			$"../../AudioStreamPlayer2D2".playing = true
			self.queue_free()
	


	if(position.y > 1700):
		Global.enemies_released -= 1
		if(Global.enemies_released == 0):
			Global.enemies_released = null
		self.queue_free()

	move_and_slide()

func _on_timer_timeout() -> void:
		timer.wait_time = randf_range(1 , 2)
		if(not death and !Global.stop_game):
			shooting = true
			#await get_tree().create_timer(0.3).timeout
			
			var bullet_scene = load("res://ALL_scenes/enemy_bullet/enemy_bullet.tscn")
			
			var bullet_RIGHT:Area2D = bullet_scene.instantiate()
			bullet_RIGHT.speed_bullet = bullet_RIGHT.speed_bullet * 1.5
			bullet_RIGHT.global_position = marker_RIGHT.global_position
			level.add_child(bullet_RIGHT)
			
			var bullet_LEFT:Area2D = bullet_scene.instantiate()
			bullet_LEFT.speed_bullet = bullet_LEFT.speed_bullet * 1.5
			bullet_LEFT.global_position = marker_LEFT.global_position
			level.add_child(bullet_LEFT)
			
			# таймер будет срабатывать в случайное время
			#await get_tree().create_timer(0.1).timeout
			shooting = false
			$AudioStreamPlayer2D.playing = true


# func _on_body_entered(body: Node2D) -> void:


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Galaxy_ship" and !death):
		death = true
		body.hp_player -= 70
		sprite2D.play("explosion")
		await sprite2D.animation_finished
		Global.enemies_released -= 1
		if(Global.enemies_released == 0):
			Global.enemies_released = null
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
			if(hp <= 0 and !death):
				death = true
				collisionPolygon.visible = false
				sprite2D.play("explosion")
				await sprite2D.animation_finished
				Global.enemies_released -= 1
				if(Global.enemies_released == 0):
					Global.enemies_released = null
				$"../../AudioStreamPlayer2D2".playing = true
				self.queue_free()
