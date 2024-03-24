extends Node

signal game_over

var winner = 0


func _ready():
	$p1_win.hide()
	$cpu_win.hide()
	$Player.hide()
	$Game.hide()
	


func new_game():
	$p1_win.hide()
	$cpu_win.hide()
	$HUD.hide() 
	$Game.show()
	winner = 0
	$Player.new_game()
	$Cpu.new_game()
	$Game/health_p1.text = "Vida: " + str($Player.health) + "/3"
	$Game/health_cpu.text = "Vida: " + str($Cpu.health) + "/3"
	$Game/p1_action.texture = load("res://assets/art/blank.png")
	$Game/cpu_action.texture = load("res://assets/art/blank.png")
	await get_tree().create_timer(1.0).timeout
	game_round()


func game_round():
	var p1_action
	var cpu_action
	while winner == 0:
		p1_action = await $Player.choose()
		cpu_action = await $Cpu.choose()
		update_img(p1_action, cpu_action)
		round_winner(p1_action, cpu_action)
		await get_tree().create_timer(2.0).timeout


func round_winner(p1_action, cpu_action):
	if p1_action == "shoot" and cpu_action == "shoot":
		var ej = "nada"
	else:
		if p1_action == "shoot" and not cpu_action == "shield":
			$Cpu.takeDamage()
		elif cpu_action == "shoot" and not p1_action == "shield":
			$Player.takeDamage()
	$Game/health_cpu.text = "Vida: " + str($Cpu.health) + "/3"
	$Game/health_p1.text = "Vida: " + str($Player.health) + "/3"


func update_img(p1_action, cpu_action):
	match p1_action:
		"shoot":
			$Game/p1_action.texture = load("res://assets/art/shoot.png")
		"shield":
			$Game/p1_action.texture = load("res://assets/art/shield.png")
		"reload":
			$Game/p1_action.texture = load("res://assets/art/reload.png")
	match cpu_action:
		"shoot":
			$Game/cpu_action.texture = load("res://assets/art/shoot.png")
		"shield":
			$Game/cpu_action.texture = load("res://assets/art/shield.png")
		"reload":
			$Game/cpu_action.texture = load("res://assets/art/reload.png")


func _on_player_p_1_dead():
	winner = 2
	game_over.emit()


func _on_cpu_cpu_dead():
	winner = 1
	game_over.emit()


func end_game():
	if winner == 1:
		await get_tree().create_timer(2.0).timeout
		$HUD.hide() 
		$Game.hide()
		$p1_win.show()
		await get_tree().create_timer(2.0).timeout
		$HUD.show()
	elif winner == 2:
		await get_tree().create_timer(2.0).timeout
		$HUD.hide() 
		$Game.hide()
		$cpu_win.show()
		await get_tree().create_timer(2.0).timeout
		$HUD.show()
