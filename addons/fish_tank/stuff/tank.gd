@tool
extends Control

var plugin_mode : bool
var tank_physics_space

	

func spawn_fish():
	var new_fish : Fish = Fish.new()
	
	$PosAnchor.add_child(new_fish)
	new_fish.global_position.y = global_position.y + size.y / 2.0
	new_fish.global_position.x = randf_range(global_position.x, size.x)
