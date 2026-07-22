extends Button

var is_dragging = false
var offset = Vector2()
var last_safe_position = Vector2() # Сюда сохраняем позицию, чтобы вернуть предмет при промахе

# ВАЖНО: Замените этот путь на путь к вашему GridContainer в дереве сцены!
@onready var grid = get_node("../../CenterContainer/PanelContainer/GridContainer") 
@onready var inventory_menu:Control = get_parent().get_parent()
@onready var galaxy_ship = get_node("../../../Galaxy_ship")

@onready var label_level:Label = $Label
@onready var label_price:Label = $Label2
@onready var texture_rect: TextureRect = $TextureRect
var num_level = 1
var num_price = null
var num_multiplier_price = null
# var ability_type = null
var ability_type = "двойной выстрел"

func _ready() -> void:
	# Запоминаем стартовую позицию предмета при запуске игры
	last_safe_position = global_position

	match ability_type:
		"двойной выстрел":
			num_multiplier_price = 4
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
	if not grid:
		print("Ошибка: GridContainer не найден!")
		return

	var closest_slot = null
	var min_distance = 10000.0
	
	# Порог примагничивания. Раз ячейка больше, можно увеличить 
	# радиус (например, до половины размера вашего слота)
	var snap_threshold = 80.0 

	for slot in grid.get_children():
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

		print("ok-",closest_slot)
		
		global_position = target_position
		last_safe_position = global_position

		inventory_menu.cells_included_forces[closest_slot].free_space = false
		inventory_menu.cells_included_forces[closest_slot].id_ability = str(self)
		# Global.player_abilities.append({
		# 	"ability_type": ability_type,
		# 	"num_level": num_level,
		# })

		
		# match ability_type:
		# 	"двойной выстрел":
		# 		galaxy_ship.hp_player += (galaxy_ship.hp_player/100) * 5
		for cell in inventory_menu.cells_included_forces:
			print(cell)
			if(cell != closest_slot and inventory_menu.cells_included_forces[cell].id_ability == str(self)):
				inventory_menu.cells_included_forces[cell].id_ability = null
				inventory_menu.cells_included_forces[cell].free_space = true
				# match ability_type:
				# 	"двойной выстрел":
				# 		galaxy_ship.hp_player -= (galaxy_ship.hp_player/100) * 5
	else:
		global_position = last_safe_position
