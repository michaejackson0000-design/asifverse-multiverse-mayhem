extends Node

var master_volume: float = 0.8
var music_volume: float = 0.7
var sfx_volume: float = 0.8

func play_sfx(_path: String) -> void:
    pass

func play_music(_path: String) -> void:
    pass

func set_master_volume(value: float) -> void:
    master_volume = value

func set_music_volume(value: float) -> void:
    music_volume = value

func set_sfx_volume(value: float) -> void:
    sfx_volume = value
