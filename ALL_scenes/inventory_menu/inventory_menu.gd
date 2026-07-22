extends Control

@onready var level: Node2D = get_parent() as Node2D
@onready var grid: GridContainer = get_node("CenterContainer/PanelContainer/GridContainer")
# @onready var grid: GridContainer = $"../../CenterContainer/PanelContainer/GridContainer"
@onready var galaxy_ship = get_node("../Galaxy_ship")
var cells_included_forces = {}

func _ready() -> void:
	for slot in grid.get_children():
		print(slot)
		print(slot.name)
		cells_included_forces[slot] = {
			"free_space": true,
			"id_ability": null,
			
		}
	print(cells_included_forces)


func _on_button_pressed() -> void:
	# for ability in Global.player_abilities:
	# 	print(ability)
	# 	match ability.ability_type:
	# 		"двойной выстрел":
	# 			galaxy_ship.hp_player += (galaxy_ship.hp_player/100) * 5
	level.click_end_menu()
