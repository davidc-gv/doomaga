extends Node2D

#this simply sets the text to equal the currentwave
func _ready():
	$scorecard.text = "YOU ONLY GOT TO WAVE " + String(get_parent().currentWave)

func _process(delta):
	$scorecard.text = "YOU ONLY GOT TO WAVE " + String(get_parent().currentWave)
