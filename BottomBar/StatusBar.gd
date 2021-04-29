extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	updateText()

#we want to update the text each round
func _process(delta):
	updateText()

#in update text we update the health and currentlevel
func updateText():
	$Health.text = String(get_parent().health)
	$Currlevel.text = String(get_parent().currentWave)

#if enemy runs into the bar we take damage too
func _on_Area2D_area_entered(area):
	
	#if an imp hits then we take damage and it goes away
	if area.is_in_group("damageable"):
		area.queue_free()
		get_parent().playerHurt()
