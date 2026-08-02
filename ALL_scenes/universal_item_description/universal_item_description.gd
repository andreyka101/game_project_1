extends Control

var num_level = 0
var num_price = 0
var num_multiplier_price = 0
var ability_type = ""
var ability_id = ""
var ability_description = ""
var list_abilities_relative_level_str =[]
var list_abilities_relative_level_int =[]

@onready var galaxy_ship = get_node("../../Galaxy_ship")
@onready var itemsContainer = get_node("../ItemsContainer")

@onready var label_ability_type: Label = $Label_ability_type
@onready var texture_rect: TextureRect = $TextureRect
@onready var rich_text_label_level_progress_list: RichTextLabel = $RichTextLabel_level_progress_list
@onready var rich_text_label_ability_description: RichTextLabel = $RichTextLabel_ability_description
@onready var button_buy: Button = $Button_buy


func start_des() -> void:
	label_ability_type.text = ability_type
	texture_rect.texture = load("res://photo/item_ability/icon_menu_" + ability_type + ".png")
	button_buy.text = str(num_price) + " coin"
	# rich_text_label_ability_description.text = ability_description
	# rich_text_label_level_progress_list.text
	var pass_level = true
	var progress_text = ""
	for ability_num in list_abilities_relative_level_str.size():
		print(ability_num)
		var color = ""
		if(ability_num + 1 == num_level):
			color = "#804922"
			pass_level = false
			rich_text_label_ability_description.text = ability_description.format({"info": list_abilities_relative_level_str[ability_num],})
		elif(pass_level):
			color = "#DACA8B"
		else:
			color = "#E56205"
		progress_text += "[color={color}]● level {ability_num} - {list}[/color]\n".format({"color": color,"ability_num": ability_num + 1,"list": list_abilities_relative_level_str[ability_num],})
	print(progress_text)
	rich_text_label_level_progress_list.text = progress_text
# 		3:
# 			rich_text_label_level_progress_list.text = "[color=#DACA8B]● level 1 - 0.5%[/color]
# [color=#DACA8B]● level 2 - 2%[/color]
# [color=#804922]● level 3 - 4%[/color]
# [color=#E56205]● level 4 - 6%[/color]
# [color=#E56205]● level 5 - 8%[/color]
# [color=#E56205]● level 6 - 10%[/color]
# [color=#E56205]● level 7 - 12.5%[/color]
# [color=#E56205]● level 8 - 15%[/color]
# [color=#E56205]● level 9 - 17.5%[/color]
# [color=#E56205]● level 10 - 20%[/color]"

func _on_button_close_pressed() -> void:
	visible = false


func _on_button_buy_pressed() -> void:
	num_level += 1
	galaxy_ship.hp_start_player -= (galaxy_ship.hp_startStart_player/100) * list_abilities_relative_level_int[num_level-2]
	galaxy_ship.hp_start_player += (galaxy_ship.hp_startStart_player/100) * list_abilities_relative_level_int[num_level-1]

	var pass_level = true
	var progress_text = ""
	for ability_num in list_abilities_relative_level_str.size():
		print(ability_num)
		var color = ""
		if(ability_num + 1 == num_level):
			color = "#804922"
			pass_level = false
			rich_text_label_ability_description.text = ability_description.format({"info": list_abilities_relative_level_str[ability_num],})
		elif(pass_level):
			color = "#DACA8B"
		else:
			color = "#E56205"
		progress_text += "[color={color}]● level {ability_num} - {list}[/color]\n".format({"color": color,"ability_num": ability_num + 1,"list": list_abilities_relative_level_str[ability_num],})
	print(progress_text)
	rich_text_label_level_progress_list.text = progress_text

	for item in itemsContainer.get_children():
		print(ability_id)
		print(item)
		if(ability_id == str(item)):
			print("---good---")
			item.num_level = num_level
			item.update_text()
