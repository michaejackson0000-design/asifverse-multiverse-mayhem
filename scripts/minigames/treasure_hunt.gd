extends "res://scripts/core/MinigameBase.gd"

func _ready() -> void:
    update_instruction("Collect the glowing relics fast!")
    duration = 4.0 + (GameManager.current_round * 0.18)
    super._ready()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        success()
