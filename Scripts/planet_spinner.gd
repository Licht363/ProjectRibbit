extends Node3D

@export var planet: Array[PackedScene]
@export var course_list: Array[String]
@export var orbit_radius: float
@export var spin_speed: float
@export var snap_speed: float
@export var planet_name_label: Label
var rotator: Node3D
var current_index:= 0
var current_angle:= 0.0

var planet_names: Array[StringName]
var selected_course: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotator = $Pivot
	spawn()
	planet_name_label.text = planet_names[0]
	selected_course = "res://Scenes/" + course_list[0] + ".tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current = rotator.rotation.y
	rotator.rotation.y = lerp_angle(current, current_angle, delta*snap_speed)

func spawn():
	var count = planet.size()
	for i in range(count):
		var angle = (TAU/count)*i
		var instance = planet[i].instantiate()
		rotator.add_child(instance)
		instance.position = Vector3(orbit_radius * sin(angle), 0, orbit_radius * cos(angle))
		instance.look_at(global_transform.origin)
		planet_names.append(instance.name)

func _input(event):
	if event.is_action_pressed("ui_left"):
		move_selection(-1)
	elif event.is_action_pressed("ui_right"):
		move_selection(1)

func move_selection(direction):
	var count = planet.size()
	current_index = (current_index + direction)%count
	var step_angle = TAU/count
	current_angle = -step_angle*current_index
	planet_name_label.text = planet_names[current_index]
	selected_course = "res://Scenes/" + course_list[current_index] + ".tscn"
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(selected_course)
