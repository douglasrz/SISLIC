package br.com.SISLIC.model;



public class ItemPedido {

	private int id_produto;	
	private int precoUnit;
	private int quantidade;
	private int id_pedido;
	private int id;
	

	
	public int getId_produto() {
		return id_produto;
	}
	public void setId_produto(int id_produto) {
		this.id_produto = id_produto;
	}
	public int getPrecoUnit() {
		return precoUnit;
	}
	public void setPrecoUnit(int precoUnit) {
		this.precoUnit = precoUnit;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public int getId_pedido() {
		return id_pedido;
	}
	public void setId_pedido(int id_pedido) {
		this.id_pedido = id_pedido;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	
}
