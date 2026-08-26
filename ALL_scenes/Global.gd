extends Node


var stop_game = false
var coin_player = 9000
var cost_items_in_store = {
	"coin_slot1": 6,
	"coin_slot2": 6,
	"coin_slot3": 6,
}



var playerAbilityLaunch_k2_GuterSchuss = {"run": false, "num": 0}



# Глобальный словарь для хранения состояния всех ячеек
var player_abilities: = []

# Функция для регистрации или обновления ячейки
# func register_cell(ability: String, num: int) -> void:
# 	player_abilities[ability] = num

# Global.register_cell(cell_id, cell_info)