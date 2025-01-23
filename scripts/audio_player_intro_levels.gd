extends AudioStreamPlayer

const INTRO_LEVELS_MUSIC = preload("res://assets/music/nin-02-ghosts-I.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if (stream == music):
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(INTRO_LEVELS_MUSIC)
	
func stop_music():
	if playing:
		stop()
		stream = null
		
