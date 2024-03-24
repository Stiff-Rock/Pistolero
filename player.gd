extends CanvasLayer

signal button_pressed
signal p1_dead

var health
var action
var ammo = 0


func _ready():
	$already_loaded.hide()
	$no_ammo.hide()


func _on_shoot_button_mouse_entered():
	$shoot_button/shoot_mp3.play()


func _on_shield_button_mouse_entered():
	$shield_button/shield_mp3.play()


func _on_reload_button_mouse_entered():
	$reload_button/reload_mp3.play()


func _on_shoot_button_pressed():
	if ammo == 0:
		var mensaje = "No tienes munición"
		$no_ammo.show()
		await get_tree().create_timer(1.0).timeout
		$no_ammo.hide()
	else:
		ammo = 0
		action = "shoot"
		button_pressed.emit()


func _on_shield_button_pressed():
	action = "shield"
	button_pressed.emit()


func _on_reload_button_pressed():
	if ammo >= 1:
		ammo = 1
		var mensaje = "Ya tienes munición"
		$already_loaded.show()
		await get_tree().create_timer(1.0).timeout
		$already_loaded.hide()
	else:
		ammo = 1
		action = "reload"
		button_pressed.emit()


func choose():
	show()
	await button_pressed
	hide()
	return action


func takeDamage():
	health -= 1
	if health <= 0:
		p1_dead.emit()


func new_game():
	health = 3
	action = ""
	ammo = 0
