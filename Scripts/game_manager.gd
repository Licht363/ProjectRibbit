extends Node3D

@export var camPivot: SpringArm3D
@export var cam: Camera3D
@export var ball: RigidBody3D
@export var zoomSmoothness: float = 2.5
@export var rotationSmoothness: float
@export var zoomSpeed: float
@export var camOffset: Vector3 = Vector3(0,0.01,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camPivot = $"../SpringArm3D"
	cam = camPivot.get_child(0)
	camPivot.spring_length = 0.75


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ball != null:
		camPivot.position = camPivot.position.lerp(ball.position, zoomSmoothness * delta) + camOffset
		#camPivot.look_at(ball.position)
		cam.look_at(ball.position)
		#print(camPivot.position, cam.rotation, cam.position)
