extends Node

func spawn_particles(_position: Vector2, _color: Color) -> void:
    pass

func screen_shake(amount: float = 8.0) -> void:
    var camera = get_viewport().get_camera_2d()
    if camera:
        camera.offset = Vector2(randf_range(-amount, amount), randf_range(-amount, amount))
