extends ParallaxBackground



var speed = 15
func _process(delta: float):
	scroll_offset.y += speed * delta
