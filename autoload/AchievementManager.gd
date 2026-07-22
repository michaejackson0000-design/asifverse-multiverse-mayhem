extends Node

signal achievement_unlocked

var achievements: Dictionary = {}

func unlock_achievement(id: String) -> void:
    if not achievements.has(id):
        achievements[id] = true
        emit_signal("achievement_unlocked", id)

func get_achievement_data() -> Dictionary:
    return achievements
