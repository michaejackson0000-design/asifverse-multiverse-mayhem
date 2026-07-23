extends Control

@onready var play_button: Button = $PlayButton
@onready var settings_button: Button = $SettingsButton
@onready var credits_button: Button = $CreditsButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	credits_button.pressed.connect(_on_credits_pressed)

func _on_play_pressed() -> void:
	print("Play pressed")

func _on_settings_pressed() -> void:
	print("Settings pressed")

func _on_credits_pressed() -> void:
	print("Credits pressed")