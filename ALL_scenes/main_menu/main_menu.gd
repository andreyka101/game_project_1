extends Node2D

func _ready():
	print(99 % 100 == 99)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ALL_scenes/level/level.tscn")
