extends TextureRect


var is_dragging = false
var offset = Vector2()
var last_safe_position = Vector2() # Сюда сохраняем позицию, чтобы вернуть предмет при промахе

# ВАЖНО: Замените этот путь на путь к вашему GridContainer в дереве сцены!
@onready var grid = get_node("../../GridContainer") 

func _ready() -> void:
	# Запоминаем стартовую позицию предмета при запуске игры
	last_safe_position = global_position

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

	if closest_slot and min_distance < snap_threshold:
		# РАСЧЕТ ЦЕНТРИРОВАНИЯ:
		# Берем левый верхний угол слота и добавляем половину разницы размеров слота и предмета.
		# Формула: ПозицияСлота + (РазмерСлота / 2) - (РазмерПредмета / 2)
		var target_position = closest_slot.global_position + (closest_slot.size / 2) - (size / 2)
		
		global_position = target_position
		last_safe_position = global_position
	else:
		global_position = last_safe_position
