extends Control

@onready var play_button: Button = $ButtonPanel/PlayButton
@onready var settings_button: Button = $ButtonPanel/SettingsButton
@onready var credits_button: Button = $ButtonPanel/CreditsButton
@onready var quit_button: Button = $ButtonPanel/QuitButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	print("Play button pressed")
	SceneManager.change_scene("res://scenes/game/game_loop.tscn")

func _on_settings_pressed() -> void:
	print("Settings button pressed")
	SceneManager.change_scene("res://scenes/ui/settings_menu.tscn")

func _on_credits_pressed() -> void:
	print("Credits button pressed")
	SceneManager.change_scene("res://scenes/ui/credits_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()