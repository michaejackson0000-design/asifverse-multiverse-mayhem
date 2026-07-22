extends "res://scripts/core/MinigameBase.gd"

func _ready() -> void:
    instruction_text = "Survive the lava floor!"
    duration = 4.0 + (GameManager.current_round * 0.2)
    super._ready()

func _process(delta: float) -> void:
    super._process(delta)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        success()
