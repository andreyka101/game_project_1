extends Button

var is_dragging = false
var offset = Vector2()
var last_safe_position = Vector2() # Сюда сохраняем позицию, чтобы вернуть предмет при промахе

# ВАЖНО: Замените этот путь на путь к вашему GridContainer в дереве сцены!
@onready var InventoryСells_Grid = get_node("../../InventoryСells_CenterContainer/InventoryСells_PanelContainer/InventoryСells_GridContainer")
@onready var inventory_menu: Control = get_parent().get_parent()
@onready var level = get_parent().get_parent().get_parent()
@onready var galaxy_ship = get_node("../../../Galaxy_ship")

@onready var label_level: Label = $Label
@onready var label_price: Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
@onready var timer: Timer = $Timer

@onready var universal_item_description: Control = $"../../Upgrade menu/universal_item_description"
@onready var upgrade_menu: Control = $"../../Upgrade menu"
@onready var ItemsContainer: Control = get_parent()
# @onready var test:Panel = $"../../CenterContainer2/PanelContainer/GridContainer/Slot1"
var num_level = 1
var num_price = [2, 5, 10, 15, 25, 35, 50, 75, 100]
var num_multiplier_price = 0
var ability_type = ""
var ability_description = ""
var not_purchased = true
var name_slot_ShopItem: String = ""
var list_abilities_relative_level_str = []
var list_abilities_relative_level_int = []
var list_items_merge = ["сила", "скорость"]

func _ready() -> void:
	# add_merge_rule(1, 1, 2)
	add_merge_rule("скорость", "сила", "скорость пули")
	add_merge_rule("защита", "скорость", "живая броня")
	add_merge_rule("защита", "сила", "хороший выстрел")

	fun_transformation_item()
	label_level.text = "level " + str(num_level)
	label_price.text = str(num_price[num_level - 1] * num_multiplier_price) + " coin"

	# Запоминаем стартовую позицию предмета при запуске игры
	last_safe_position = global_position
	# Подключаем сигналы мыши/нажатия кнопки к функциям
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	timer.timeout.connect(_on_timer_timeout)


# Вызывается в момент, когда игрок ТОЛЬКО НАЖАЛ и держит кнопку
func _on_button_down() -> void:
	timer.start() # Запускаем отсчет времени

# Вызывается, если игрок ОТПУСТИЛ кнопку
func _on_button_up() -> void:
	# Если таймер еще тикает, значит зажатие было слишком коротким
	if not timer.is_stopped():
		timer.stop() # Сбрасываем таймер
		print("Нажатие слишком короткое!")

# Вызывается АВТОМАТИЧЕСКИ, если кнопка удерживалась достаточно долго
func _on_timer_timeout() -> void:
	_execute_action()

# Место для вашего действия
func _execute_action() -> void:
	for slot in InventoryСells_Grid.get_children():
		var slot_center = slot.global_position + (slot.size / 2)
		var item_center = global_position + (size / 2)
		if (item_center.distance_to(slot_center) < 30):
			print("Действие выполнено после короткого зажатия!")
			universal_item_description.num_level = num_level
			universal_item_description.num_multiplier_price = num_multiplier_price
			universal_item_description.ability_type = ability_type
			universal_item_description.ability_id = str(self )
			universal_item_description.ability_description = ability_description
			universal_item_description.list_abilities_relative_level_str = list_abilities_relative_level_str
			universal_item_description.list_abilities_relative_level_int = list_abilities_relative_level_int
			upgrade_menu.visible = true
			universal_item_description.start_des()

func fun_changing_text():
	label_level.text = "level " + str(num_level)
	label_price.text = str(num_price[num_level - 1] * num_multiplier_price) + " coin"
func fun_transformation_item():
	match ability_type:
		"защита":
			num_multiplier_price = 1
			ability_description = "[color=#997800]увеличивает hp на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["5%", "10%", "17%", "35%", "50%", "75%", "110%", "150%", "200%", "350%", ]
			list_abilities_relative_level_int = [5, 10, 17, 35, 50, 75, 110, 150, 200, 350]
		"сила":
			num_multiplier_price = 1
			ability_description = "[color=#997800]увеличивает урон пули на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["5%", "10%", "17%", "35%", "50%", "75%", "110%", "150%", "200%", "350%", ]
			list_abilities_relative_level_int = [5, 10, 17, 35, 50, 75, 110, 150, 200, 350]
		"скорость":
			num_multiplier_price = 1
			ability_description = "[color=#997800]увеличивает скорость корабля на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["5%", "10%", "17%", "35%", "50%", "75%", "110%", "150%", "200%", "350%", ]
			list_abilities_relative_level_int = [5, 10, 17, 35, 50, 75, 110, 150, 200, 350]
		"скорость пули":
			num_multiplier_price = 2
			ability_description = "[color=#997800]увеличивает скорость пули на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["5%", "10%", "17%", "35%", "50%", "75%", "110%", "150%", "200%", "350%", ]
			list_abilities_relative_level_int = [5, 10, 17, 35, 50, 75, 110, 150, 200, 350]
		"живая броня":
			num_multiplier_price = 2
			ability_description = "[color=#997800]восстановление брони раз в[/color] [color=#804922]{info}[/color] [color=#997800]сек на 5 единиц[/color]"
			list_abilities_relative_level_str = ["100 сек", "90 сек", "80 сек", "70 сек", "60 сек", "50 сек", "40 сек", "30 сек", "20 сек", "10 сек", ]
			list_abilities_relative_level_int = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10]
		"хороший выстрел":
			num_multiplier_price = 2
			ability_description = "[color=#997800]25% шанс восстановить броню за убийство врага на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["0.1%", "0.2%", "0.3%", "0.5%", "0.7%", "1%", "1.2%", "1.5%", "1.7%", "2%"]
			list_abilities_relative_level_int = [0.1, 0.2, 0.3, 0.5, 0.7, 1, 1.2, 1.5, 1.7, 2]
	texture_rect.texture = load("res://photo/item_ability/icon_menu_" + ability_type + ".png")
	# print("res://photo/item_ability/icon_menu_" + ability_type + ".png")
# photo/item_ability/icon_menu_защита.png


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				# Считаем разницу между курсором и левым верхним углом предмета
				offset = get_global_mouse_position() - global_position
				# Поднимаем предмет визуально выше других на экране во время таскания
				z_index = 10
			else:
				is_dragging = false
				z_index = 0
				snap_to_nearest_slot()

func _process(_delta: float) -> void:
	if is_dragging and Global.cost_items_in_store.coin_slot1 <= Global.coin_player:
		# Передвигаем вслед за мышкой
		global_position = get_global_mouse_position() - offset
	elif (is_dragging and !not_purchased):
		global_position = get_global_mouse_position() - offset

func snap_to_nearest_slot() -> void:
	if not InventoryСells_Grid:
		print("Ошибка: GridContainer не найден!")
		return

	var closest_slot = null
	var min_distance = 10000.0
	
	# Порог примагничивания. Раз ячейка больше, можно увеличить 
	# радиус (например, до половины размера вашего слота)
	var snap_threshold = 80.0

	for slot in InventoryСells_Grid.get_children():
		var slot_center = slot.global_position + (slot.size / 2)
		var item_center = global_position + (size / 2)
		
		var distance = item_center.distance_to(slot_center)
		if distance < min_distance:
			min_distance = distance
			closest_slot = slot

	if closest_slot and min_distance < snap_threshold and inventory_menu.cells_included_forces[closest_slot].free_space:
		var target_position = closest_slot.global_position + (closest_slot.size / 2) - (size / 2)
		print("start a-n test_1")
		# print(inventory_menu.cells_included_forces)
		# print(str(self))
		# print(ability_type)
		if (not_purchased):
			fun_force_increase_decrease()
			if (name_slot_ShopItem == "slot1"):
				inventory_menu.free_ShopItem_Dictionary.slot1 = true
				inventory_menu.funShopItem()
				not_purchased = false
			if (name_slot_ShopItem == "slot2"):
				inventory_menu.free_ShopItem_Dictionary.slot2 = true
				inventory_menu.funShopItem()
				not_purchased = false
			if (name_slot_ShopItem == "slot3"):
				inventory_menu.free_ShopItem_Dictionary.slot3 = true
				inventory_menu.funShopItem()
				not_purchased = false
		global_position = target_position
		last_safe_position = global_position
		inventory_menu.cells_included_forces[closest_slot].free_space = false
		inventory_menu.cells_included_forces[closest_slot].id_ability = str(self )
		inventory_menu.cells_included_forces[closest_slot].name_ability = ability_type
		inventory_menu.cells_included_forces[closest_slot].level_ability = num_level
		for cell in inventory_menu.cells_included_forces:
			if (cell != closest_slot and inventory_menu.cells_included_forces[cell].id_ability == str(self )):
				inventory_menu.cells_included_forces[cell].id_ability = null
				inventory_menu.cells_included_forces[cell].name_ability = null
				inventory_menu.cells_included_forces[cell].level_ability = null
				inventory_menu.cells_included_forces[cell].free_space = true
		print("start a-n test_2")
		print(inventory_menu.cells_included_forces)
	elif closest_slot and min_distance < snap_threshold and !inventory_menu.cells_included_forces[closest_slot].free_space:
		print("start a-a test_1")
		print(inventory_menu.cells_included_forces)

		var beginning_merging_item = false
		if (inventory_menu.cells_included_forces[closest_slot].id_ability != str(self )):
			var result = find_merge_result(ability_type, inventory_menu.cells_included_forces[closest_slot].name_ability)
			if (!not_purchased):
				fun_force_increase_decrease(-1)
			if not result.is_empty():
				ability_type = result
				beginning_merging_item = true
		if (beginning_merging_item):
			print("start a-a test_2")
			for cell in inventory_menu.cells_included_forces:
				if (cell != closest_slot and inventory_menu.cells_included_forces[cell].id_ability == str(self )):
					inventory_menu.cells_included_forces[cell].id_ability = null
					inventory_menu.cells_included_forces[cell].name_ability = null
					inventory_menu.cells_included_forces[cell].level_ability = null
					inventory_menu.cells_included_forces[cell].free_space = true
			if (name_slot_ShopItem == "slot1"):
				if (not_purchased):
					if (name_slot_ShopItem == "slot1"):
						inventory_menu.free_ShopItem_Dictionary.slot1 = true
						inventory_menu.funShopItem()
					not_purchased = false
			if (name_slot_ShopItem == "slot2"):
				if (not_purchased):
					if (name_slot_ShopItem == "slot2"):
						inventory_menu.free_ShopItem_Dictionary.slot2 = true
						inventory_menu.funShopItem()
					not_purchased = false
			if (name_slot_ShopItem == "slot3"):
				if (not_purchased):
					if (name_slot_ShopItem == "slot3"):
						inventory_menu.free_ShopItem_Dictionary.slot3 = true
						inventory_menu.funShopItem()
					not_purchased = false
			name_slot_ShopItem = ""
			not_purchased = false
			var target_position = closest_slot.global_position + (closest_slot.size / 2) - (size / 2)
			var del_item = ItemsContainer.get_node(inventory_menu.cells_included_forces[closest_slot].id_ability.split(":")[0])
			if (del_item):
				num_level = int((num_level + del_item.num_level) / 2)
				fun_transformation_item()
				fun_changing_text()
				del_item.fun_force_increase_decrease(-1)
				del_item.queue_free()
			inventory_menu.cells_included_forces[closest_slot].name_ability = ability_type
			inventory_menu.cells_included_forces[closest_slot].id_ability = str(self )
			inventory_menu.cells_included_forces[closest_slot].level_ability = num_level
			fun_force_increase_decrease()
			global_position = target_position
			last_safe_position = global_position
			# print(inventory_menu.cells_included_forces)
		else:
			global_position = last_safe_position

	else:
		global_position = last_safe_position

# Класс для правил слияния
class MergeRule:
	var ability1: String
	var ability2: String
	var result: String
	
	func _init(a1: String, a2: String, res: String):
		ability1 = a1
		ability2 = a2
		result = res

# Создаём список правил
var merge_rules = []

func add_merge_rule(ability1: String, ability2: String, result: String):
	merge_rules.append(MergeRule.new(ability1, ability2, result))

func find_merge_result(ability_a: String, ability_b: String) -> String:
	for rule in merge_rules:
		# Проверяем обе комбинации
		if (rule.ability1 == ability_a and rule.ability2 == ability_b) or \
		   (rule.ability1 == ability_b and rule.ability2 == ability_a):
			return rule.result
	return "" # Нет результата

func update_text() -> void:
	for cell in inventory_menu.cells_included_forces:
		if (inventory_menu.cells_included_forces[cell].id_ability == str(self )):
			inventory_menu.cells_included_forces[cell].level_ability = num_level

	label_level.text = "level " + str(num_level)
	if (num_level < 10):
		label_price.text = str(num_price[num_level - 1] * num_multiplier_price) + " coin"
		if (num_price[num_level - 1] * num_multiplier_price > Global.coin_player):
			label_price.add_theme_color_override("font_color", Color("#FF2B2B"))
		else:
			label_price.add_theme_color_override("font_color", Color("#997800"))
	else:
		label_price.text = "full"
		label_price.add_theme_color_override("font_color", Color("#997800"))

func fun_force_increase_decrease(minus = 1) -> void:
	match ability_type:
		"защита":
			galaxy_ship.hp_start_player += (round((galaxy_ship.hp_startStart_player / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus
			galaxy_ship.hp_player += (round((galaxy_ship.hp_startStart_player / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus
		"сила":
			galaxy_ship.damage += (round((galaxy_ship.damage_Start / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus
		"скорость":
			# print((round((galaxy_ship.speed_ship_Start / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus)
			galaxy_ship.speed_ship += (round((galaxy_ship.speed_ship_Start / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus
		"скорость пули":
			galaxy_ship.speed_bullet += (round((galaxy_ship.speed_bullet_Start / 100.0) * list_abilities_relative_level_int[num_level - 1] * 100) / 100.0) * minus
		"живая броня":
			var num_this_type = 0
			var num_average_value = 0
			for cell in inventory_menu.cells_included_forces:
				if (inventory_menu.cells_included_forces[cell].name_ability == "живая броня"):
					num_this_type += 1
					num_average_value += inventory_menu.cells_included_forces[cell].level_ability
			if (num_this_type == 1):
				galaxy_ship.ability_k1_livingArmor = {"run": true, "num": list_abilities_relative_level_int[num_level - 1], "plus_hp": 5}
			else:
				galaxy_ship.ability_k1_livingArmor = {"run": true, "num": list_abilities_relative_level_int[int(num_average_value / num_this_type) - 1], "plus_hp": num_this_type * 5}
			level.hp_ship_battery_passiveсharging.visible = true
			level.HP_ship_battery.visible = false
		"хороший выстрел":
			var num_this_type = 0
			var num_average_value = 0
			for cell in inventory_menu.cells_included_forces:
				if (inventory_menu.cells_included_forces[cell].name_ability == "хороший выстрел"):
					num_this_type += 1
					num_average_value += inventory_menu.cells_included_forces[cell].level_ability
			if (num_this_type == 1):
				Global.playerAbilityLaunch_k2_GuterSchuss = {"run": true, "num": list_abilities_relative_level_int[num_level - 1]}
			else:
				Global.playerAbilityLaunch_k2_GuterSchuss = {"run": true, "num": list_abilities_relative_level_int[int(num_average_value / num_this_type) - 1] * num_this_type}
			# Global.playerAbilityLaunch_k2_GuterSchuss = {"run": true, "num": list_abilities_relative_level_int[num_level - 1]}
			
	if (num_level < 10):
		if (num_price[num_level - 1] * num_multiplier_price > Global.coin_player):
			label_price.add_theme_color_override("font_color", Color("#FF2B2B"))
		else:
			label_price.add_theme_color_override("font_color", Color("#997800"))
	else:
		label_price.add_theme_color_override("font_color", Color("#997800"))
