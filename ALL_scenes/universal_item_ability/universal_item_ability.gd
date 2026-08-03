extends Button

var is_dragging = false
var offset = Vector2()
var last_safe_position = Vector2() # Сюда сохраняем позицию, чтобы вернуть предмет при промахе

# ВАЖНО: Замените этот путь на путь к вашему GridContainer в дереве сцены!
@onready var InventoryСells_Grid = get_node("../../InventoryСells_CenterContainer/InventoryСells_PanelContainer/InventoryСells_GridContainer") 
@onready var inventory_menu:Control = get_parent().get_parent()
@onready var galaxy_ship = get_node("../../../Galaxy_ship")

@onready var label_level:Label = $Label
@onready var label_price:Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
@onready var timer: Timer = $Timer

@onready var universal_item_description: Control = $"../../Upgrade menu/universal_item_description"
@onready var upgrade_menu: Control = $"../../Upgrade menu"
@onready var ItemsContainer:Control = get_parent()
# @onready var test:Panel = $"../../CenterContainer2/PanelContainer/GridContainer/Slot1"
var num_level = 1
var num_price = [2,5,10,15,25,35,50,75,100]
var num_multiplier_price = 0
var ability_type = ""
var ability_description = ""
var not_purchased = true
var name_slot_ShopItem:String = ""
var list_abilities_relative_level_str = []
var list_abilities_relative_level_int = []

func _ready() -> void:
	fun_transformation_item()
	label_level.text = "level " + str(num_level)
	label_price.text = str(num_price[num_level - 1]) + " coin"

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
		if(item_center.distance_to(slot_center) < 10):
			print("Действие выполнено после короткого зажатия!")
			universal_item_description.num_level = num_level
			universal_item_description.num_multiplier_price = num_multiplier_price
			universal_item_description.ability_type = ability_type
			universal_item_description.ability_id = str(self)
			universal_item_description.ability_description = ability_description
			universal_item_description.list_abilities_relative_level_str = list_abilities_relative_level_str
			universal_item_description.list_abilities_relative_level_int = list_abilities_relative_level_int
			upgrade_menu.visible = true
			universal_item_description.start_des()

func fun_transformation_item():
	match ability_type:
		"защита":
			num_multiplier_price = 1
			ability_description = "[color=#997800]увеличивает hp на[/color] [color=#804922]{info}[/color]"
			list_abilities_relative_level_str = ["5%","10%","17%","35%","50%","75%","110%","150%","200%","350%",]
			list_abilities_relative_level_int = [5,10,17,35,50,75,110,150,200,350,]
	texture_rect.texture = load("res://photo/item_ability/icon_menu_" + ability_type + ".png")
	print("res://photo/item_ability/icon_menu_" + ability_type + ".png")
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
	elif(is_dragging and !not_purchased):
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
		# РАСЧЕТ ЦЕНТРИРОВАНИЯ:
		# Берем левый верхний угол слота и добавляем половину разницы размеров слота и предмета.
		# Формула: ПозицияСлота + (РазмерСлота / 2) - (РазмерПредмета / 2)
		var target_position = closest_slot.global_position + (closest_slot.size / 2) - (size / 2)

		if(not_purchased):
			fun_force_increase_decrease()
			if(name_slot_ShopItem=="slot1"):
				inventory_menu.free_ShopItem_Dictionary.slot1 = true
				inventory_menu.funShopItem()
				not_purchased = false
				# Global.coin_player -= Global.cost_items_in_store.coin_slot1

		print("ok-",closest_slot)
		
		global_position = target_position
		last_safe_position = global_position

		inventory_menu.cells_included_forces[closest_slot].free_space = false
		inventory_menu.cells_included_forces[closest_slot].id_ability = str(self)
		inventory_menu.cells_included_forces[closest_slot].name_ability = ability_type

		# match ability_type:
		# 	"двойной выстрел":
		# 		galaxy_ship.hp_player += (galaxy_ship.hp_player/100) * 5
		for cell in inventory_menu.cells_included_forces:
			# print(cell)
			if(cell != closest_slot and inventory_menu.cells_included_forces[cell].id_ability == str(self)):
				inventory_menu.cells_included_forces[cell].id_ability = null
				inventory_menu.cells_included_forces[cell].name_ability = null
				inventory_menu.cells_included_forces[cell].free_space = true
				# match ability_type:
				# 	"двойной выстрел":
				# 		galaxy_ship.hp_player -= (galaxy_ship.hp_player/100) * 5
	elif closest_slot and min_distance < snap_threshold and !inventory_menu.cells_included_forces[closest_slot].free_space:
		# print("not not ok-",closest_slot)
		var beginning_merging_item = false

		if(inventory_menu.cells_included_forces[closest_slot].id_ability != str(self)):
			match ability_type:
				"двойной выстрел":
					match inventory_menu.cells_included_forces[closest_slot].name_ability:
						"двойной выстрел":
							ability_type = "скорость пули"
							beginning_merging_item = true
			
		for cell in inventory_menu.cells_included_forces:
			# print(cell)
			if(cell != closest_slot and inventory_menu.cells_included_forces[cell].id_ability == str(self)):
				inventory_menu.cells_included_forces[cell].id_ability = null
				inventory_menu.cells_included_forces[cell].name_ability = null
				inventory_menu.cells_included_forces[cell].free_space = true

		if(beginning_merging_item):
			if(name_slot_ShopItem=="slot1"):
				# inventory_menu.free_ShopItem_Dictionary.slot1 = true
				# inventory_menu.funShopItem()
				if(not_purchased):
					if(name_slot_ShopItem=="slot1"):
						inventory_menu.free_ShopItem_Dictionary.slot1 = true
						inventory_menu.funShopItem()
					not_purchased = false
			name_slot_ShopItem = ""
			not_purchased = false
			var target_position = closest_slot.global_position + (closest_slot.size / 2) - (size / 2)
			fun_transformation_item()
			var del_item = ItemsContainer.get_node(inventory_menu.cells_included_forces[closest_slot].id_ability.split(":")[0])
			print('inventory_menu.cells_included_forces[closest_slot].id_ability.split(":")[0]')
			print(inventory_menu.cells_included_forces[closest_slot].id_ability.split(":")[0])
			if(del_item):
				del_item.queue_free()
			inventory_menu.cells_included_forces[closest_slot].id_ability = null
			inventory_menu.cells_included_forces[closest_slot].name_ability = null
			inventory_menu.cells_included_forces[closest_slot].free_space = true
			global_position = target_position
			last_safe_position = global_position
		else:
			global_position = last_safe_position

	else:
		global_position = last_safe_position


func update_text() -> void:
	label_level.text = "level " + str(num_level)
	if(num_level < 10):
		label_price.text = str(num_price[num_level - 1]) + " coin"
	else:
		label_price.text = "full"

func fun_force_increase_decrease() -> void:
	# galaxy_ship.hp_start_player += (galaxy_ship.hp_player/100) * 5
	galaxy_ship.hp_start_player += (galaxy_ship.hp_startStart_player/100) * list_abilities_relative_level_int[0]
