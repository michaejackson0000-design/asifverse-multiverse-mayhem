extends "res://scripts/core/MinigameBase.gd"

func _ready() -> void:
    update_instruction("Repair the robot core before it shuts down!")
    duration = 5.0 + (GameManager.current_round * 0.15)
    super._ready()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        success()
