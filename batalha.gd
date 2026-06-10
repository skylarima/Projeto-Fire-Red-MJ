extends Node2D

@onready var label_tipo_jogador = $PokemonJogador/Tipo
@onready var label_nivel_jogador = $PokemonJogador/Nivel
@onready var label_vida_jogador = $PokemonJogador/Vida
@onready var label_especie_jogador = $PokemonJogador/Jogador

var pokemon_jogador = Global.pokemon_jogador
func _ready() -> void:
	carregar_pokemon_jogador()
	
func carregar_pokemon_jogador():
	label_especie_jogador.text = pokemon_jogador["especie"]
