extends Control

@onready var level: Node2D = get_parent() as Node2D
@onready var inventoryСells_Grid: GridContainer = get_node("InventoryСells_CenterContainer/InventoryСells_PanelContainer/InventoryСells_GridContainer")
# @onready var inventoryСells_Grid: GridContainer = $"../../CenterContainer/PanelContainer/GridContainer"
@onready var galaxy_ship = get_node("../Galaxy_ship")
var cells_included_forces = {}
var start_game = true
@onready var coin_label: Label = $Coin_HBoxContainer/Coin_Panel/Coin_CenterContainer/Coin_Label
@onready var shopCoin_Slot1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Label_coin1"
@onready var shopCoin_Slot2 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Label_coin2"
@onready var shopCoin_Slot3 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Label_coin3"

@onready var itemsContainer = $"ItemsContainer"
@onready var shopItem_Slot1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot1"
@onready var none_coid_plug1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot1/none_coid_plug1"
@onready var shopItem_Slot2 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot2"
@onready var none_coid_plug2 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot2/none_coid_plug2"
@onready var shopItem_Slot3 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot3"
@onready var none_coid_plug3 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot3/none_coid_plug3"
var free_ShopItem_Dictionary = {
	"slot1": true,
	"slot2": true,
	"slot3": true,
}
# var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
@onready var ship_protection_label: Label = $PlayerStatistics_VBoxContainer/ShipProtection_Label
@onready var ship_speed_label: Label = $PlayerStatistics_VBoxContainer/ShipSpeed_Label
@onready var bullet_speed_label: Label = $PlayerStatistics_VBoxContainer/BulletSpeed_Label
@onready var bullet_force_label: Label = $PlayerStatistics_VBoxContainer/BulletForce_Label
@onready var reloading_label: Label = $PlayerStatistics_VBoxContainer/Reloading_Label
@onready var hp_progress_bar: ProgressBar = $HP_ProgressBar
@onready var healing_button: Button = $HealingButton

var num_price_healing = 0

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
	# funStartGame_ShopItem()


func funStartGame_ShopItem() -> void:
	await get_tree().process_frame
	var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
	print("new item1")
	var new_item: Button = save_item_class.instantiate()
	new_item.global_position = shopItem_Slot1.global_position + (shopItem_Slot1.size / 2) - (new_item.size / 2)
	new_item.name_slot_ShopItem = "slot1"
	free_ShopItem_Dictionary.slot1 = false
	new_item.ability_type = "защита"
	itemsContainer.add_child(new_item)

	print("new item2")
	new_item = save_item_class.instantiate()
	new_item.global_position = shopItem_Slot2.global_position + (shopItem_Slot2.size / 2) - (new_item.size / 2)
	new_item.name_slot_ShopItem = "slot2"
	free_ShopItem_Dictionary.slot2 = false
	new_item.ability_type = "сила"
	itemsContainer.add_child(new_item)

	print("new item3")
	new_item = save_item_class.instantiate()
	new_item.global_position = shopItem_Slot3.global_position + (shopItem_Slot3.size / 2) - (new_item.size / 2)
	new_item.name_slot_ShopItem = "slot3"
	free_ShopItem_Dictionary.slot3 = false
	new_item.ability_type = "скорость"
	itemsContainer.add_child(new_item)
func funShopItem() -> void:
	if (free_ShopItem_Dictionary.slot1):
		Global.coin_player -= Global.cost_items_in_store.coin_slot1
		Global.cost_items_in_store.coin_slot1 = int(1.5 * Global.cost_items_in_store.coin_slot1)
		coin_label.text = str(Global.coin_player) + " coin"
		shopCoin_Slot1.text = str(Global.cost_items_in_store.coin_slot1) + " coin"
		print("new item1")
		var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
		var new_item: Button = save_item_class.instantiate()
		new_item.global_position = shopItem_Slot1.global_position + (shopItem_Slot1.size / 2) - (new_item.size / 2)
		new_item.name_slot_ShopItem = "slot1"
		free_ShopItem_Dictionary.slot1 = false
		new_item.ability_type = "защита"
		itemsContainer.add_child(new_item)

	if (free_ShopItem_Dictionary.slot2):
		Global.coin_player -= Global.cost_items_in_store.coin_slot2
		Global.cost_items_in_store.coin_slot2 = int(1.5 * Global.cost_items_in_store.coin_slot2)
		coin_label.text = str(Global.coin_player) + " coin"
		shopCoin_Slot2.text = str(Global.cost_items_in_store.coin_slot2) + " coin"
		print("new item2")
		var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
		var new_item: Button = save_item_class.instantiate()
		new_item.global_position = shopItem_Slot2.global_position + (shopItem_Slot2.size / 2) - (new_item.size / 2)
		new_item.name_slot_ShopItem = "slot2"
		free_ShopItem_Dictionary.slot2 = false
		new_item.ability_type = "сила"
		itemsContainer.add_child(new_item)

	if (free_ShopItem_Dictionary.slot3):
		Global.coin_player -= Global.cost_items_in_store.coin_slot3
		Global.cost_items_in_store.coin_slot3 = int(1.5 * Global.cost_items_in_store.coin_slot3)
		coin_label.text = str(Global.coin_player) + " coin"
		shopCoin_Slot3.text = str(Global.cost_items_in_store.coin_slot3) + " coin"
		print("new item3")
		var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")
		var new_item: Button = save_item_class.instantiate()
		new_item.global_position = shopItem_Slot3.global_position + (shopItem_Slot3.size / 2) - (new_item.size / 2)
		new_item.name_slot_ShopItem = "slot3"
		free_ShopItem_Dictionary.slot3 = false
		new_item.ability_type = "скорость"
		itemsContainer.add_child(new_item)

func _on_button_pressed() -> void:
	# for ability in Global.player_abilities:
	# 	print(ability)
	# 	match ability.ability_type:
	# 		"двойной выстрел":
	# 			galaxy_ship.hp_player += (galaxy_ship.hp_player/100) * 5
	level.click_end_menu()


func _process(_delta: float) -> void:
# 	coin_label.text = str(Global.coin_player) + " coin"
# 	shopCoin_Slot1.text = str(Global.cost_items_in_store.coin_slot1) + " coin"
	ship_protection_label.text = "защита корабля - " + str(int(galaxy_ship.hp_start_player))
	ship_speed_label.text = "скорость корабля - " + str(int(galaxy_ship.speed_ship))
	bullet_speed_label.text = "скорость пули - " + str(int(galaxy_ship.speed_bullet))
	bullet_force_label.text = "сила пули - " + str(int(galaxy_ship.damage))
	reloading_label.text = "перезарядка - " + str(int(galaxy_ship.time_timer * 100))
	hp_progress_bar.value = int(galaxy_ship.hp_player * 100 / galaxy_ship.hp_start_player)
	healing_button.text = "+ 25% HP\n\n" + str((level.num_level_hard / 10 + 1) * 5) + " coin"
	print("ttt")
	print(1+1/2)
	# print("ggg")
	# print(12/10)
	# print("=-=")
	if (Global.cost_items_in_store.coin_slot1 > Global.coin_player):
		shopCoin_Slot1.add_theme_color_override("font_color", Color("#FF2B2B"))
		none_coid_plug1.visible = true
	else:
		shopCoin_Slot1.add_theme_color_override("font_color", Color("#ffffff"))
		none_coid_plug1.visible = false
	if (Global.cost_items_in_store.coin_slot2 > Global.coin_player):
		shopCoin_Slot2.add_theme_color_override("font_color", Color("#FF2B2B"))
		none_coid_plug2.visible = true
	else:
		shopCoin_Slot2.add_theme_color_override("font_color", Color("#ffffff"))
		none_coid_plug2.visible = false
	if (Global.cost_items_in_store.coin_slot3 > Global.coin_player):
		shopCoin_Slot3.add_theme_color_override("font_color", Color("#FF2B2B"))
		none_coid_plug3.visible = true
	else:
		shopCoin_Slot3.add_theme_color_override("font_color", Color("#ffffff"))
		none_coid_plug3.visible = false


func _on_healing_button_pressed() -> void:
	if(Global.coin_player >= (level.num_level_hard / 10 + 1) * 5):
		Global.coin_player -= (level.num_level_hard / 10 + 1) * 5
		galaxy_ship.hp_player += (galaxy_ship.hp_start_player/100) * 25
		coin_label.text = str(Global.coin_player) + " coin"
		if(galaxy_ship.hp_player > galaxy_ship.hp_start_player):
			galaxy_ship.hp_player = galaxy_ship.hp_start_player
