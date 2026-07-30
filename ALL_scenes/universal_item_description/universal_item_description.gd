extends Control

var num_level = 0
var num_price = 0
var num_multiplier_price = 0
var ability_type = ""
var ability_description = ""

@onready var label_ability_type: Label = $Label_ability_type
@onready var texture_rect: TextureRect = $TextureRect
@onready var rich_text_label_level_progress_list: RichTextLabel = $RichTextLabel_level_progress_list
@onready var rich_text_label_ability_description: RichTextLabel = $RichTextLabel_ability_description
@onready var button_buy: Button = $Button_buy


func start_des() -> void:
	label_ability_type.text = ability_type
	texture_rect.texture = load("res://icon_menu_" + ability_type + ".png")
	button_buy.text = str(num_price) + " coin"
	# rich_text_label_ability_description.text = ability_description
	match num_level:
		1:
			rich_text_label_level_progress_list.text = "[color=#804922]● level 1 - 0.5%[/color]
[color=#E56205]● level 2 - 2%[/color]
[color=#E56205]● level 3 - 4%[/color]
[color=#E56205]● level 4 - 6%[/color]
[color=#E56205]● level 5 - 8%[/color]
[color=#E56205]● level 6 - 10%[/color]
[color=#E56205]● level 7 - 12.5%[/color]
[color=#E56205]● level 8 - 15%[/color]
[color=#E56205]● level 9 - 17.5%[/color]
[color=#E56205]● level 10 - 20%[/color]"
		2:
			rich_text_label_level_progress_list.text = "[color=#DACA8B]● level 1 - 0.5%[/color]
[color=#804922]● level 2 - 2%[/color]
[color=#E56205]● level 3 - 4%[/color]
[color=#E56205]● level 4 - 6%[/color]
[color=#E56205]● level 5 - 8%[/color]
[color=#E56205]● level 6 - 10%[/color]
[color=#E56205]● level 7 - 12.5%[/color]
[color=#E56205]● level 8 - 15%[/color]
[color=#E56205]● level 9 - 17.5%[/color]
[color=#E56205]● level 10 - 20%[/color]"
		3:
			rich_text_label_level_progress_list.text = "[color=#DACA8B]● level 1 - 0.5%[/color]
[color=#DACA8B]● level 2 - 2%[/color]
[color=#804922]● level 3 - 4%[/color]
[color=#E56205]● level 4 - 6%[/color]
[color=#E56205]● level 5 - 8%[/color]
[color=#E56205]● level 6 - 10%[/color]
[color=#E56205]● level 7 - 12.5%[/color]
[color=#E56205]● level 8 - 15%[/color]
[color=#E56205]● level 9 - 17.5%[/color]
[color=#E56205]● level 10 - 20%[/color]"

func _on_button_close_pressed() -> void:
	visible = false


func _on_button_buy_pressed() -> void:
	pass # Replace with function body.
