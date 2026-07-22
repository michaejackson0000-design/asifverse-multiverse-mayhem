extends Node

signal score_changed
signal combo_changed

var high_score: int = 0
var score: int = 0
var combo: int = 0
var streak: int = 0
var multiplier: int = 1
var unlocked_characters: Array = ["Rin"]
var statistics: Dictionary = {
    "rounds_completed": 0,
    "bosses_defeated": 0,
    "mini_games_completed": 0
}

func add_score(value: int) -> void:
    score += value
    if score > high_score:
        high_score = score
    emit_signal("score_changed", score)

func reset_combo() -> void:
    combo = 0
    streak = 0
    multiplier = 1
    emit_signal("combo_changed", combo, multiplier)

func increase_combo() -> void:
    combo += 1
    streak += 1
    multiplier = 1 + (streak / 5)
    emit_signal("combo_changed", combo, multiplier)
