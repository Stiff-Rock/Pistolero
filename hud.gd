extends CanvasLayer

signal new_game


func _on_play_button_pressed():
	new_game.emit()
