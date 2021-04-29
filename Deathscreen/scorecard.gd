extends Label


func _ready():
	text = "YOU ONLY GOT TO WAVE " + String(get_parent().get_parent().currentWave) + "?"

func _process(delta):
	text = "YOU ONLY GOT TO WAVE " + String(get_parent().get_parent().currentWave) + "?"
