@tool
class_name Fish
extends RigidBody2D


var main_control : Control

var sprite : Sprite2D ## temp, need to construct on init

var target_pos : Vector2
var swim_interval_timer : Timer

func _init() -> void:
	swim_interval_timer = Timer.new()
	add_child(swim_interval_timer)
	
	sprite = Sprite2D.new()
	sprite.texture = load("res://addons/fish_tank/Fish/BriFish_TEX.png")
	sprite.scale = Vector2(0.1,0.1)
	add_child(sprite)
	
	var colshape : CollisionShape2D = CollisionShape2D.new()
	colshape.shape = CircleShape2D.new()
	colshape.visible = false
	add_child(colshape)
	
	mass = 0.001
	gravity_scale = 0.01
	lock_rotation = true
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.bounce = .9
	
	swim_interval_timer.autostart = true
	swim_interval_timer.wait_time = randf_range(0.5,0.85)
	
func _ready() -> void:
	main_control = get_parent().get_parent()
	if Engine.is_editor_hint():
		PhysicsServer2D.body_set_space(self.get_rid(),main_control.tank_physics_space)
	
	pick_new_target()

func _process(delta: float) -> void:
	if position.distance_to(target_pos) <= 20:
		pick_new_target()
		print("new")
func _physics_process(delta: float) -> void:
	
	linear_velocity.x = clamp(linear_velocity.x, -30.0,30.0)
	linear_velocity.y = clamp(linear_velocity.y, -30.0,30.0)
	
	
		
	
	await swim_interval_timer.timeout
	var _angle: Vector2 = Vector2.from_angle(get_angle_to(target_pos))
	apply_impulse(_angle * delta * 0.05)
	if rad_to_deg(get_angle_to(target_pos)) <= 0:
		sprite.flip_h = false
	elif rad_to_deg(get_angle_to(target_pos)) > 0:
		sprite.flip_h = true
	swim_interval_timer.wait_time = randf_range(0.5,1.5)


func pick_new_target():
	target_pos.x = randf_range(main_control.global_position.x + 80.0,main_control.global_position.x + main_control.size.x - 80.0)
	target_pos.y = randf_range(main_control.global_position.y + 80.0,main_control.global_position.y + main_control.size.y - 80.0)
	#target_pos = main_control.get_global_transform_with_canvas() * target_pos
	print(target_pos)
	
	
	
	
