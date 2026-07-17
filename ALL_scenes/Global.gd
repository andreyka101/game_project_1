extends Node


var stop_game = false



# Глобальный словарь для хранения состояния всех ячеек
var menu_cells: Dictionary = {}

# Функция для регистрации или обновления ячейки
func register_cell(cell_id: int, cell_data: Dictionary) -> void:
	menu_cells[cell_id] = cell_data

# Global.register_cell(cell_id, cell_info)