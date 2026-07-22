extends "res://scripts/core/MinigameBase.gd"

func _ready() -> void:
    update_instruction("Defend the station with perfect timing!")
    duration = 5.0 + (GameManager.current_round * 0.2)
    super._ready()

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        success()
