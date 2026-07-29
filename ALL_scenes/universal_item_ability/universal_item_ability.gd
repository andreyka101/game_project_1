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

@onready var inventoryMenu: Control = $"../../"
@onready var ItemsContainer:Control = get_parent()
# @onready var test:Panel = $"../../CenterContainer2/PanelContainer/GridContainer/Slot1"
var num_level = 1
var num_price = 2
var num_multiplier_price = 0
var ability_type = ""
# var ability_type = "двойной выстрел"
var not_purchased = true
var name_slot_ShopItem:String = ""

func _ready() -> void:
	# await get_tree().process_frame 
	# global_position = test.global_position + (test.size / 2) - (size / 2)

	# Запоминаем стартовую позицию предмета при запуске игры
	last_safe_position = global_position
	fun_transformation_item()
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
			var save_item_description_class = load("res://ALL_scenes/universal_item_description/universal_item_description.tscn")
			var new_item_description:Control = save_item_description_class.instantiate()
			# new_item.global_position = shopItem_Slot1.global_position + (shopItem_Slot1.size / 2) - (new_item.size / 2)
			inventoryMenu.add_child(new_item_description)
	# Сюда пишите ваш код (переход на другой уровень, удаление предмета и т.д.)


func fun_transformation_item():
	match ability_type:
		"двойной выстрел":
			num_multiplier_price = 4
		"скорость пули":
			num_multiplier_price = 2
	texture_rect.texture = load("res://icon_menu_" + ability_type + ".png")


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
	if is_dragging:
		# Передвигаем вслед за мышкой
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
			if(name_slot_ShopItem=="slot1"):
				inventory_menu.free_ShopItem_Dictionary.slot1 = true
				inventory_menu.funShopItem()
				not_purchased = false

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
