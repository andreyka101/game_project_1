extends AudioStreamPlayer2D

func _ready() -> void:
	var rand_num = randi_range(1, 11)
	self.stream = load("res://audio/explosions of enemies/boom_%s.mp3" % rand_num)
	if (rand_num == 1): self.volume_db = 7
	elif (rand_num == 2): 
		self.volume_db = -10
		self.pitch_scale = 1.5
	elif (rand_num == 3): self.volume_db = 8
	elif (rand_num == 4): self.volume_db = 9
	elif (rand_num == 5): self.volume_db = 13
	elif (rand_num == 6): self.volume_db = 6
	elif (rand_num == 7): self.volume_db = 0
	elif (rand_num == 8): self.volume_db = 13
	elif (rand_num == 9): self.volume_db = 0
	elif (rand_num == 10): self.volume_db = 10
	elif (rand_num == 11): self.volume_db = 10

	self.playing = true



func _on_finished() -> void:
	self.queue_free()
