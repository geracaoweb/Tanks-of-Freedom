extends "res://scripts/bag_aware.gd"

var unit_brains = {
    "soldier" : preload("res://scripts/yuri/actions/brains/soldier_brain.gd").new(),
    "tank" : preload("res://scripts/yuri/actions/brains/tank_brain.gd").new(),
    "heli" : preload("res://scripts/yuri/actions/brains/heli_brain.gd").new(),
}

var building_brains = {
    "hq" : preload("res://scripts/yuri/actions/brains/hq_brain.gd").new(),
    "barracks" : preload("res://scripts/yuri/actions/brains/barracks_brain.gd").new(),
    "factory" : preload("res://scripts/yuri/actions/brains/factory_brain.gd").new(),
    "airport" : preload("res://scripts/yuri/actions/brains/airport_brain.gd").new(),
    "gsm tower" : preload("res://scripts/yuri/actions/brains/tower_brain.gd").new(),
}


func _initialize():
    for key in self.unit_brains:
        self.unit_brains[key]._init_bag(self.bag)
    for key in self.building_brains:
        self.building_brains[key]._init_bag(self.bag)


func get_available_actions(current_player):
    var building_actions = self._collect_building_actions(current_player)
    var unit_actions = self._collect_unit_actions(current_player)

    var combined_actions = []

    for action in building_actions:
        combined_actions.append(action)

    for action in unit_actions:
        combined_actions.append(action)

    return combined_actions


func _collect_building_actions(current_player):
    var buildings = self.bag.positions.get_player_buildings(current_player)
    var enemies = self.bag.positions.get_enemy_units(current_player)
    var units = self.bag.positions.get_player_units(current_player)

    var brain
    var current_building_actions
    var collected_actions = []

    for building in buildings:
        brain = self._get_building_brain(building)
        current_building_actions = brain.get_actions(building, enemies, units)

        for action in current_building_actions:
            collected_actions.append(action)

    return collected_actions


func _collect_unit_actions(current_player):
    var units = self.bag.positions.get_player_units(current_player)
    var enemies = self.bag.positions.get_enemy_units(current_player)
    var buildings = self.bag.positions.get_not_owned_buildings(current_player)
    return []


func _get_building_brain(building):
    return

func _get_unit_brain(unit):
    return