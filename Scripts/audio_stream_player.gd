extends Node
var music_player: AudioStreamPlayer
var ambient_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
@export var background_music: AudioStreamWAV



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_player = $"."
	ambient_player = $"../AmbientPlayer"
	sfx_player = $"../SFXPlayer"
	play_music(background_music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_music(stream: AudioStreamWAV, cross_fade_duration: float = 1.0):
	if stream != null:
		music_player.stream = stream

func play_sfx(stream: AudioStreamWAV, pitch_variance: float = 0.0):
	if sfx_player != null && !sfx_player.playing:
		sfx_player.stream = stream
	if pitch_variance > 0.0:
		sfx_player.pitch_scale = 1 + randf_range(-pitch_variance, pitch_variance)
	else:
		sfx_player.pitch_scale = 1
	sfx_player.play()
	return
