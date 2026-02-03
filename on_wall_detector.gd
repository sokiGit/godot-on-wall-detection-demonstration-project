extends Node

@export var label: Label;

func _on_player_state_signal(state: Variant) -> void:
	label.text = "State: "
	match state:
		PlayerBody3D.State.Air:
			label.text += "Air";
		PlayerBody3D.State.Floor:
			label.text += "Floor";
		PlayerBody3D.State.Wall:
			label.text += "Wall"
	
