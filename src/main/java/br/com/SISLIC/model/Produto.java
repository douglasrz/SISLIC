package br.com.SISLIC.model;

import java.io.Serializable;

public class Produto implements Serializable {
	
	private String nome;	
	private int id;
	private String descricao;
	private Categoria categoria;
	private int quantidade;
	private float preco;
	private int IdItemPedido;//PARA SER UTILIZADO NA BUSCA DO PREÇO DO PRODUTO NO LANCE
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}	
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getPreco() {
		return preco;
	}
	public void setPreco(float preco) {
		this.preco = preco;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public int getIdItemPedido() {
		return IdItemPedido;
	}
	public void setIdItemPedido(int idItemPedido) {
		IdItemPedido = idItemPedido;
	}
	
	
	
}
