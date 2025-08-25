extends Node2D
@onready var pause = $Pause
@onready var settings_level = $"Settings_level"
@onready var parallaxBackground = $"../ParallaxBackground_var_1"
@onready var enemies:Node2D = $"../Enemies"
@onready var galaxy_ship:CharacterBody2D = $'../Galaxy_ship'
@onready var label_hp: Label = $Settings_level/Control_hp/Label
@onready var label_speed: Label = $Settings_level/Control_speed/Label
@onready var label_speed_bullet: Label = $Settings_level/Control_speed_bullet/Label
@onready var label_damage: Label = $Settings_level/Control_damage/Label
@onready var label_reload: Label = $Settings_level/Control_reload/Label

func _on_pause_pressed() -> void:
	# print(enemies.type)
	pause.visible = false
	settings_level.visible = true
	Global.stop_game = true
	parallaxBackground.speed = 0
	label_hp.text = "max hp = " + str(galaxy_ship.hp_start_player)
	label_speed.text = "скорость = " + str(galaxy_ship.speed_ship)
	label_speed_bullet.text = "скорость пули = " + str(galaxy_ship.speed_bullet)
	label_damage.text = "урон = " + str(galaxy_ship.damage)
	label_reload.text = "перезарядка = " + str(galaxy_ship.time_timer)
	for child in enemies.get_children():
		if(child.name_str == "explosive drone"):
			child.sprite_fire.stop()
			child.sprite_head.stop()
		else:
			child.sprite2D.stop()



func _on_сontinue_pressed() -> void:
	pause.visible = true
	settings_level.visible = false
	Global.stop_game = false
	parallaxBackground.speed = 15
	for child in enemies.get_children():
		if(child.name_str == "explosive drone"):
			child.sprite_fire.play_backwards()
			child.sprite_head.play_backwards()
		else:
			child.sprite2D.play_backwards()


func _on_button_hp_pressed() -> void:
	galaxy_ship.hp_start_player +=  round((galaxy_ship.hp_start_player/100.0) * 10 * 100) / 100.0
	galaxy_ship.hp_player +=  round((galaxy_ship.hp_player/100.0) * 10 * 100) / 100.0
	label_hp.text = "max hp = " + str(galaxy_ship.hp_start_player)

func _on_button_speed_pressed() -> void:
	galaxy_ship.speed_ship +=  round((galaxy_ship.speed_ship/100.0) * 10 * 100) / 100.0
	label_speed.text = "скорость = " + str(galaxy_ship.speed_ship)


func _on_button_speed_bullet_pressed() -> void:
	galaxy_ship.speed_bullet +=  round((galaxy_ship.speed_bullet/100.0) * 10 * 100) / 100.0
	label_speed_bullet.text = "скорость пули = " + str(galaxy_ship.speed_bullet)


func _on_button_damage_pressed() -> void:
	galaxy_ship.damage +=  round((galaxy_ship.damage/100.0) * 10 * 100) / 100.0
	label_damage.text = "урон = " + str(galaxy_ship.damage)


func _on_button_reload_pressed() -> void:
	galaxy_ship.time_timer -=  round((galaxy_ship.time_timer/100.0) * 10 * 100) / 100.0
	galaxy_ship.timer.wait_time = galaxy_ship.time_timer
	label_reload.text = "перезарядка = " + str(galaxy_ship.time_timer)
	
