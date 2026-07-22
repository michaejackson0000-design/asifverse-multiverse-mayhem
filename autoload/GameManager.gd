extends Node

signal game_started
signal game_paused
signal game_resumed
signal game_over
signal round_started
signal boss_started

var current_round: int = 0
var max_rounds: int = 30
var is_paused: bool = false
var boss_round_interval: int = 10
var current_state: String = "splash"

func start_game() -> void:
    current_round = 0
    current_state = "playing"
    emit_signal("game_started")
    start_round()

func start_round() -> void:
    current_round += 1
    emit_signal("round_started", current_round)
    if current_round % boss_round_interval == 0:
        emit_signal("boss_started", current_round)

func pause_game() -> void:
    if is_paused:
        return
    is_paused = true
    emit_signal("game_paused")

func resume_game() -> void:
    if not is_paused:
        return
    is_paused = false
    emit_signal("game_resumed")

func end_game() -> void:
    current_state = "game_over"
    emit_signal("game_over")
