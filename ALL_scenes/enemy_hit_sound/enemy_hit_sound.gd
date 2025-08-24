extends AudioStreamPlayer2D

func _ready() -> void:
	var rand_num = randi_range(1, 15)
	self.stream = load("res://audio/hitting the enemy/hit_%s.mp3" % rand_num)
	if (rand_num == 1): self.volume_db = 0
	elif (rand_num == 2): self.volume_db = 0
	elif (rand_num == 3): 
		self.volume_db = 3.5
		self.pitch_scale = 1.5
	elif (rand_num == 4): 
		self.volume_db = 6
		self.pitch_scale = 1.2
	elif (rand_num == 5): 
		self.volume_db = 7
		self.pitch_scale = 1.1
	elif (rand_num == 6): 
		self.volume_db = 2
		self.pitch_scale = 1.1
	elif (rand_num == 7): self.volume_db = 5
	elif (rand_num == 8): self.volume_db = 4
	elif (rand_num == 9): self.volume_db = 3
	elif (rand_num == 10): self.volume_db = 0
	elif (rand_num == 11): self.volume_db = 0
	elif (rand_num == 12): self.volume_db = 0
	elif (rand_num == 13): self.volume_db = 1
	elif (rand_num == 14): self.volume_db = 0
	elif (rand_num == 15): self.volume_db = 7

	self.playing = true



func _on_finished() -> void:
	self.queue_free()
