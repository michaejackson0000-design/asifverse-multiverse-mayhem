extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var credits_button: Button = $VBoxContainer/CreditsButton

func _ready() -> void:
    play_button.pressed.connect(_on_play_pressed)
    settings_button.pressed.connect(_on_settings_pressed)
    credits_button.pressed.connect(_on_credits_pressed)

func _on_play_pressed() -> void:
    GameManager.start_game()
    SceneManager.change_scene("res://scenes/game/game_loop.tscn")

func _on_settings_pressed() -> void:
    SceneManager.change_scene("res://scenes/ui/settings_menu.tscn")

func _on_credits_pressed() -> void:
    SceneManager.change_scene("res://scenes/ui/credits_menu.tscn")
