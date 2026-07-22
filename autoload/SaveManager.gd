extends Node

const SAVE_PATH: String = "res://save/game_save.json"

func save_game() -> void:
    var data = {
        "high_score": ScoreManager.high_score,
        "settings": SettingsManager.get_settings_data(),
        "achievements": AchievementManager.get_achievement_data(),
        "unlocked_characters": ScoreManager.unlocked_characters,
        "statistics": ScoreManager.statistics
    }
    var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(data))
        file.close()

func load_game() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}
    var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not file:
        return {}
    var content = file.get_as_text()
    file.close()
    return JSON.parse_string(content) if content else {}
