extends Node

signal minigame_started
signal minigame_completed
signal minigame_failed

var available_minigames: Array = []
var active_minigame: String = ""

func _ready() -> void:
    var file = FileAccess.open("res://data/minigames.json", FileAccess.READ)
    if file:
        var content = file.get_as_text()
        var parsed = JSON.parse_string(content)
        if parsed:
            available_minigames = parsed.get("minigames", [])
        file.close()

func get_random_minigame() -> Dictionary:
    if available_minigames.is_empty():
        return {}
    return available_minigames[randi() % available_minigames.size()]

func start_minigame(minigame_id: String) -> void:
    active_minigame = minigame_id
    emit_signal("minigame_started", minigame_id)

func complete_minigame() -> void:
    emit_signal("minigame_completed", active_minigame)

func fail_minigame() -> void:
    emit_signal("minigame_failed", active_minigame)
