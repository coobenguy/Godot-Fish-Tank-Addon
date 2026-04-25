@tool
extends EditorPlugin

var output_panel : RichTextLabel
var fish_tank : Control

var defualt_physics_space : RID
var tank_physics_space : RID

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	output_panel = get_node("/root/@EditorNode@19360/@Panel@14/@VBoxContainer@15/DockVSplitMain/DockHSplitMain/@VBoxContainer@37/DockVSplitCenter/@EditorBottomPanel@7960/Output/@HBoxContainer@7962/@VBoxContainer@7963/@RichTextLabel@7966")
	var emptyStyle : StyleBoxEmpty = StyleBoxEmpty.new()
	output_panel.add_theme_stylebox_override("normal", emptyStyle)
	output_panel.add_theme_stylebox_override("focus", emptyStyle)
	#output_panel.add_theme_color_override("font_outline_color", Color.BLACK)
	output_panel.add_theme_color_override("font_outline_color", Color(0.0,0.0,0.0,0.5))
	output_panel.add_theme_color_override("font_shadow_color", Color(0.0,0.0,0.0,0.5))
	output_panel.add_theme_constant_override("outline_size", 8)
	output_panel.add_theme_constant_override("shadow_outline_size", 9)
	output_panel.add_theme_constant_override("shadow_offset_y", 4)
	output_panel.z_index = 1
	#output_panel.visible = false
	defualt_physics_space = get_tree().root.world_2d.space
	tank_physics_space = PhysicsServer2D.space_create()
	
	PhysicsServer2D.space_set_active(defualt_physics_space, false)
	PhysicsServer2D.space_set_active(tank_physics_space,true)
	PhysicsServer2D.set_active(true)
	
	var tank_scene : PackedScene = load("res://addons/fish_tank/Tank.tscn")
	fish_tank = tank_scene.instantiate()
	fish_tank.tank_physics_space = tank_physics_space
	output_panel.add_child(fish_tank)
	
	for i in 15:
		fish_tank.spawn_fish()
	

	## try to set physics ticks low ?
func _process(delta: float) -> void:
	PhysicsServer2D.space_set_active(defualt_physics_space, false)


func _exit_tree() -> void:
	#output_panel.visible = true
	
	fish_tank.queue_free()
	PhysicsServer2D.set_active(false)
	
