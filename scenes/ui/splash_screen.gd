extends Control

func _ready() -> void:
    await get_tree().create_timer(1.5).timeout
    SceneManager.change_scene("res://scenes/menu/main_menu.tscn")
