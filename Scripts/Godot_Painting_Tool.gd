@tool
extends Node3D
@export var Prefab: PackedScene
@export var BrushSize: float = 1
@export var ContinuousPaint: bool = false

var isPainting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		return
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		isPainting = event.pressed
		if isPainting && not ContinuousPaint:
			_paint_once(event.position)
			
	if ContinuousPaint and isPainting and event is InputEventMouseMotion:
		_paint_once(event.position)


func _paint_once(mousePosition):
	var viewport:= get_viewport()
	var camera:= viewport.get_camera_3d()
	if camera == null:
		return
	var origin:= camera.project_ray_origin(mousePosition)
	var dir = camera.project_ray_normal(mousePosition)
	
	var spaceState = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(origin, origin + dir * 2000)
	var result = spaceState.intersect_ray(query)
	
	if result:
		var hitPos = result.position
		
		var instance = Prefab.instantiate()
		instance.global_position = hitPos
		
		get_tree().current_scene.add_child(instance)
