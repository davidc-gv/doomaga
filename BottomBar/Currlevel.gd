extends Label

#simply set textboxes equal to the roots curentwave data on startup and loop
func _ready():
	text = String(get_parent().get_parent().currentWave)

func _process(delta):
	text = String(get_parent().get_parent().currentWave)
