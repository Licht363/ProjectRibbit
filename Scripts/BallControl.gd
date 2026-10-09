extends RigidBody3D

var ball = self
var distance: float = 10
@export var label_a: Label
@export var label_b: Label
@export var label_c: Label
@export var multiplier_label: Label
var height: float
var curve: float
@export var direction = Vector3(curve,height,distance)
var minigame_started: bool
var multiplier: float
@export var minigame_obj: ColorRect
var minigame_indicator: ColorRect
var max_position_a = 0
var max_position_b = 564
var time_elapsed: float = 0
@export var hit_sfx: 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigame_obj.hide()
	minigame_indicator = minigame_obj.get_child(0).get_child(0)

func update_data():
	if label_a != null:
		label_a.text = str(curve)
	if label_b != null:
		label_b.text = str(height)
	if label_c != null:
		label_c.text = str(distance)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	direction = Vector3(curve, height, distance)
	update_data()
	if Input.is_action_just_pressed("Arc Curve In"):
		height += 1
	if Input.is_action_just_pressed("Arc Curve Out"):
		height -= 1
	if Input.is_action_just_pressed("Arc Curve Left"):
		curve += 1
	if Input.is_action_just_pressed("Arc Curve Right"):
		curve -= 1
	
	if Input.is_action_just_pressed("Lower"):
		distance -= 1
	if Input.is_action_just_pressed("Raise"):
		distance += 1
	
	if Input.is_action_just_pressed("Click") && !minigame_started:
		minigame_start()
	if minigame_started:
		minigame_run(delta)
	if Input.is_action_just_released("Click") && minigame_started:
		minigame_select()
		
#When Idendifying Mechanics
# Input
# Tranformation
# State & Logic
# Detcection
# Communication

func minigame_start():
	minigame_started = true
	minigame_obj.show()
	
	

func minigame_run(t: float):
	time_elapsed += t * 1.0
	var new_time: float = (-cos(time_elapsed) + 1.0)/2
	multiplier = lerpf(0.1,1,new_time)
	minigame_indicator.position.x = lerpf(max_position_a, max_position_b, new_time)
	multiplier_label.text = str(multiplier)

func minigame_select():
	minigame_started = false
	apply_hit()
	minigame_obj.hide()

func apply_hit():
	apply_impulse(direction * multiplier)
