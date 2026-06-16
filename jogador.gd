extends CharacterBody2D

var tamanho_tile = 16
@export var duracao_movimento = 0.1

var direcao := Vector2i.ZERO
var movendo = false

@export var grade_fase : TileMapLayer
var posicao_grid = Vector2i.ZERO


func _ready() -> void:
	posicao_grid = grade_fase.local_to_map(position)
	position = grade_fase.map_to_local(posicao_grid)
	
func _physics_process(delta: float) -> void:
	
	mover_grid()
	
	move_and_slide()

func mover_grid():
	
	if movendo == true:
		return
		
	direcao = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	if direcao == Vector2i.ZERO:
		return
	
	if direcao.x != 0 and direcao.y != 0:
		direcao = Vector2i(sign(direcao.x), 0)
		
	posicao_grid = grade_fase.local_to_map(position)
	
	var coordenadas_final = posicao_grid + direcao
	
	var proximo_bloco = grade_fase.get_cell_tile_data(coordenadas_final)
	
	if proximo_bloco == null:
		return
	
	if proximo_bloco.get_custom_data("Blocked") == true:
		return
	
	var posicao_final = grade_fase.map_to_local(coordenadas_final)
	
	var movimento_tween = create_tween()
	
	movimento_tween.tween_property(self,"position", posicao_final, duracao_movimento)
	
	movendo = true
	
	await movimento_tween.finished
	
	movendo = false
	if proximo_bloco.get_custom_data("Perigo") == true:
		entrar_em_batalha()
	
func entrar_em_batalha():
	var numero_aleatorio = randi_range(1,100)
	
	if numero_aleatorio <= 11:
		var pokemon_oponente = get_parent().pokemons.pick()
		Global.pokemon_oponente = pokemon_oponente
		get_tree().change_scene_to_file("res://batalha.tscn")
	else:
		print("nao entrou em batalha")
		
