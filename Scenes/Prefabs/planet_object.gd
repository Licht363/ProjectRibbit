extends Node3D

@onready var planet: MeshInstance3D = $MeshInstance3D
var dummy_names: Array = ["planet a","planet b","planet c","planet d"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var material:= StandardMaterial3D.new()
	material.albedo_color = Color(randf(),randf(),randf())
	planet.material_override = material
	self.name = StringName(dummy_names[randi()%4])
	print(self.name)
