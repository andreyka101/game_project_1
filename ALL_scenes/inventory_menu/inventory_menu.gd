extends Control

@onready var level: Node2D = get_parent() as Node2D
@onready var inventoryСells_Grid: GridContainer = get_node("InventoryСells_CenterContainer/InventoryСells_PanelContainer/InventoryСells_GridContainer")
# @onready var inventoryСells_Grid: GridContainer = $"../../CenterContainer/PanelContainer/GridContainer"
@onready var galaxy_ship = get_node("../Galaxy_ship")
var cells_included_forces = {}
var start_game = true
@onready var coin_label: Label = $Coin_HBoxContainer/Coin_Panel/Coin_CenterContainer/Coin_Label
@onready var shopCoin_Slot1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Label_coin1"

@onready var itemsContainer = $"ItemsContainer"
@onready var shopItem_Slot1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot1"
@onready var none_coid_plug1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot1/none_coid_plug1"
var free_ShopItem_Dictionary = {
	"slot1": true,
	"slot2": true,
	"slot3": true,
}
# var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")

func _ready() -> void:
	await get_tree().process_frame 
	for slot in inventoryСells_Grid.get_children():
		print(slot)
		print(slot.name)
		cells_included_forces[slot] = {
			"free_space": true,
			"id_ability": null,
			"name_ability": null,
		}
	print(cells_included_forces)
	funStartGame_ShopItem()



func funStartGame_ShopItem() -> void:
	await get_tree().process_frame 
	print("new item1")
	var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
	var new_item:Button = save_item_class.instantiate()
	new_item.global_position = shopItem_Slot1.global_position + (shopItem_Slot1.size / 2) - (new_item.size / 2)
	new_item.name_slot_ShopItem = "slot1"
	free_ShopItem_Dictionary.slot1 = false
	new_item.ability_type = "двойной выстрел"
	itemsContainer.add_child(new_item)
func funShopItem() -> void:
	if(free_ShopItem_Dictionary.slot1):
		Global.coin_player -= Global.cost_items_in_store.coin_slot1
		Global.cost_items_in_store.coin_slot1 += 3
		coin_label.text = str(Global.coin_player) + " coin"
		shopCoin_Slot1.text = str(Global.cost_items_in_store.coin_slot1) + " coin"
		if(Global.cost_items_in_store.coin_slot1 > Global.coin_player):
			shopCoin_Slot1.add_theme_color_override("font_color", Color("#FF2B2B"))
			none_coid_plug1.visible = true
		else:
			shopCoin_Slot1.add_theme_color_override("font_color", Color("#ffffff"))
			none_coid_plug1.visible = false
		print("new item1")
		var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
		var new_item:Button = save_item_class.instantiate()
		new_item.global_position = shopItem_Slot1.global_position + (shopItem_Slot1.size / 2) - (new_item.size / 2)
		new_item.name_slot_ShopItem = "slot1"
		free_ShopItem_Dictionary.slot1 = false
		new_item.ability_type = "двойной выстрел"
		itemsContainer.add_child(new_item)

func _on_button_pressed() -> void:
	# for ability in Global.player_abilities:
	# 	print(ability)
	# 	match ability.ability_type:
	# 		"двойной выстрел":
	# 			galaxy_ship.hp_player += (galaxy_ship.hp_player/100) * 5
	level.click_end_menu()


# func _process(_delta: float) -> void:
# 	coin_label.text = str(Global.coin_player) + " coin"
# 	shopCoin_Slot1.text = str(Global.cost_items_in_store.coin_slot1) + " coin"
