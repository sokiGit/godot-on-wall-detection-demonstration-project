extends Camera3D

@export var player: CharacterBody3D;
@export var cam_root: Marker3D;

@export var sensitivity_x: float = 0.015;
@export var sensitivity_y: float = 0.015;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * sensitivity_x);
		cam_root.rotate_x(-event.relative.y * sensitivity_y)

		cam_root.rotation.x = clampf(cam_root.rotation.x, -1.5, 1.5)
