extends Control

@onready var level: Node2D = get_parent() as Node2D
@onready var inventoryСells_Grid: GridContainer = get_node("InventoryСells_CenterContainer/InventoryСells_PanelContainer/InventoryСells_GridContainer")
# @onready var inventoryСells_Grid: GridContainer = $"../../CenterContainer/PanelContainer/GridContainer"
@onready var galaxy_ship = get_node("../Galaxy_ship")
var cells_included_forces = {}


@onready var itemsContainer = $"ItemsContainer"
@onready var shopItem_Slot1 = $"ShopItem_CenterContainer/ShopItem_PanelContainer/ShopItem_GridContainer/Slot1"
var free_ShopItem_Dictionary = {
	"slot1": true,
	"slot2": true,
	"slot3": true,
}
# var save_item_class = load("res://ALL_scenes/universal_item_ability/universal_item_ability.tscn")

func _ready() -> void:
	for slot in inventoryСells_Grid.get_children():
		print(slot)
		print(slot.name)
		cells_included_forces[slot] = {
			"free_space": true,
			"id_ability": null,
			
		}
	print(cells_included_forces)

	await get_tree().process_frame 
	funShopItem()



func funShopItem() -> void:
	if(free_ShopItem_Dictionary.slot1):
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
