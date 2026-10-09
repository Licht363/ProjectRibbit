extends Control

@export var scene_to_load: String = "String"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	load_level(scene_to_load)


func load_level(level: String):
	var path = "res://Scenes/"+level+".tscn"
	get_tree().change_scene_to_file(path)

func _on_exit_pressed() -> void:
	get_tree().quit()
