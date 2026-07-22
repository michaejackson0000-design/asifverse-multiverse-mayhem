extends "res://scripts/core/MinigameBase.gd"

func _ready() -> void:
    instruction_text = "Dodge the asteroids!"
    duration = 5.0 + (GameManager.current_round * 0.15)
    super._ready()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        success()
