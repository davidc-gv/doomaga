extends AnimatedSprite

func _ready():
	play()


func _on_Imp_tree_exiting():
	queue_free()
