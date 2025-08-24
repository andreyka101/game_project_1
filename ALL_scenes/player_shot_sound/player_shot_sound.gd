extends AudioStreamPlayer2D

func _ready() -> void:
	# self.stream = load("res://audio/выстрел для игрока.mp3")
	# self.volume_db = 30
	self.playing = true
	

func _on_finished() -> void:
	self.queue_free()
