extends Node

var master_volume: float = 0.8
var music_volume: float = 0.7
var sfx_volume: float = 0.8
var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready() -> void:
    music_player = AudioStreamPlayer.new()
    music_player.bus = "Master"
    music_player.autoplay = false
    add_child(music_player)

    sfx_player = AudioStreamPlayer.new()
    sfx_player.bus = "Master"
    sfx_player.autoplay = false
    add_child(sfx_player)

func play_sfx(path: String) -> void:
    if not ResourceLoader.exists(path):
        return
    var stream = load(path)
    if stream and stream is AudioStream:
        sfx_player.stream = stream
        sfx_player.volume_db = linear2db(master_volume * sfx_volume)
        sfx_player.play()

func play_music(path: String, loop: bool = true) -> void:
    if not ResourceLoader.exists(path):
        return
    var stream = load(path)
    if stream and stream is AudioStream:
        music_player.stream = stream
        music_player.volume_db = linear2db(master_volume * music_volume)
        music_player.loop = loop
        music_player.play()

func stop_music() -> void:
    if music_player:
        music_player.stop()

func set_master_volume(value: float) -> void:
    master_volume = clamp(value, 0.0, 1.0)
    if music_player:
        music_player.volume_db = linear2db(master_volume * music_volume)
    if sfx_player:
        sfx_player.volume_db = linear2db(master_volume * sfx_volume)

func set_music_volume(value: float) -> void:
    music_volume = clamp(value, 0.0, 1.0)
    if music_player:
        music_player.volume_db = linear2db(master_volume * music_volume)

func set_sfx_volume(value: float) -> void:
    sfx_volume = clamp(value, 0.0, 1.0)
    if sfx_player:
        sfx_player.volume_db = linear2db(master_volume * sfx_volume)
