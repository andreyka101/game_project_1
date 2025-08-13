extends Node2D
@onready var pause = $Pause
@onready var settings_level = $"Settings_level"
@onready var parallaxBackground = $"../ParallaxBackground_var_1"
func _on_pause_pressed() -> void:
	pause.visible = false
	settings_level.visible = true
	Global.stop_game = true
	parallaxBackground.speed = 0


func _on_сontinue_pressed() -> void:
	pause.visible = true
	settings_level.visible = false
	Global.stop_game = false
	parallaxBackground.speed = 15
