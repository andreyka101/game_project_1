extends Node


var stop_game = false
var coin_player = 99990
var cost_items_in_store = {
	"coin_slot1": 6,
	"coin_slot2": 6,
	"coin_slot3": 6,
}


var playerAbilityLaunch_k2_GuterSchuss = {"run": false, "num": 0}
var playerAbilityLaunch_k4_AdditionalShot_2 = {"run": false, "chance": 0}
var playerAbilityLaunch_k4_AdditionalShot_3 = {"run": false, "chance": 0}
var playerAbilityLaunch_k5_BestShot = {"run": false, "num": 0}
var playerAbilityLaunch_k6_PerfectShot = {"run": false, "num": 0}


# Глобальный словарь для хранения состояния всех ячеек
var player_abilities := []

# Функция для регистрации или обновления ячейки
# func register_cell(ability: String, num: int) -> void:
# 	player_abilities[ability] = num

# Global.register_cell(cell_id, cell_info)


func universal_function_all_enemies_death(galaxy_ship) -> void:
	if (Global.playerAbilityLaunch_k2_GuterSchuss.run):
		if (randi_range(0, 3) == 1 and galaxy_ship.hp_player < galaxy_ship.hp_start_player):
			galaxy_ship.hp_player += (round(galaxy_ship.hp_start_player / 100.0) * Global.playerAbilityLaunch_k2_GuterSchuss.num)
			galaxy_ship.universal_indicator_HP_recovery_enemies()
			if (galaxy_ship.hp_player > galaxy_ship.hp_start_player):
				galaxy_ship.hp_player = galaxy_ship.hp_start_player
	if (Global.playerAbilityLaunch_k5_BestShot.run):
		if (randi_range(0, 4) == 1):
			galaxy_ship.hp_player += (round(galaxy_ship.hp_start_player / 100.0) * Global.playerAbilityLaunch_k5_BestShot.num)
			galaxy_ship.universal_indicator_HP_recovery_enemies()
	if (Global.playerAbilityLaunch_k6_PerfectShot.run):
		# if(randi_range(0, 4) == 1):
		if(true):
			galaxy_ship.damage += (round((galaxy_ship.damage_Start / 100.0) * Global.playerAbilityLaunch_k6_PerfectShot.num * 100) / 100.0)
			if (galaxy_ship.hp_player < galaxy_ship.hp_start_player):
				galaxy_ship.hp_player += (round(galaxy_ship.hp_start_player / 100.0) * Global.playerAbilityLaunch_k6_PerfectShot.num)
				galaxy_ship.universal_indicator_HP_recovery_enemies()
				if (galaxy_ship.hp_player > galaxy_ship.hp_start_player):
					galaxy_ship.hp_player = galaxy_ship.hp_start_player
