extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	
#this changes the animation in our status bar depending on our health
#we simply change animations (based on the current health, light, etc)
func _process(delta):
	if get_parent().get_parent().health > 70:
		animation = "healthy"
	elif get_parent().get_parent().health >= 60:
		animation = "light"
	elif get_parent().get_parent().health > 40:
		animation = "damaged"
	elif get_parent().get_parent().health > 10:
		 animation = "dying"
	
