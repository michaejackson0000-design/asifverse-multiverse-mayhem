extends Node

signal settings_changed

var settings: Dictionary = {
    "master_volume": 0.8,
    "music_volume": 0.7,
    "sfx_volume": 0.8,
    "fullscreen": false,
    "windowed": true,
    "keybindings": {
        "move_left": KEY_A,
        "move_right": KEY_D,
        "jump": KEY_SPACE
    }
}

func get_settings_data() -> Dictionary:
    return settings

func apply_settings() -> void:
    emit_signal("settings_changed")
