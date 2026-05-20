extends CharacterBody2D

var tamanho_tile = 16
var duracao_movimento = 0.5

var direcao = Vector2.ZERO
var movendo = false

func _physics_process(delta: float) -> void:
	
	mover_grid()
	
	move_and_slide()

func mover_grid():
	
	if movendo == true:
		return
		
	direcao = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	if direcao == Vector2.ZERO:
		return
	
	if direcao.x != 0 and direcao.y != 0:
		direcao = Vector2(sign(direcao.x), 0)
		
	var posicao_final = position + (direcao*tamanho_tile)
	
	var movimento_tween = create_tween()
	
	movimento_tween.tween_property(self,"position", posicao_final, duracao_movimento)
	
	#var scale_tween = create_tween()
	#if direcao.x != 0:
		#scale_tween.tween_property(self, "scale", Vector2(1.2,0.8), 0.15)
	#else:
		#scale_tween.tween_property(self, "scale", Vector2(0.8,1.2), 0.15)
	#scale_tween.tween_property(self, "scale", Vector2(1,1), 0.15)
	
	movendo = true
	
	await movimento_tween.finished
	
	movendo = false
	
