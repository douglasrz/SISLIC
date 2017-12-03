package br.com.SISLIC.model;

import java.io.Serializable;
import java.sql.Date;

public class Lance implements Serializable{

	private int id;
	private float ValorTotal;
	private Fornecedor fornecedor;
	private Date data;
	private float taxaEntrega;
	private Pedido pedido;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getTaxaEntrega() {
		return taxaEntrega;
	}
	public void setTaxaEntrega(float taxaEntrega) {
		this.taxaEntrega = taxaEntrega;
	}
	
	public float getValorTotal() {
		return ValorTotal;
	}
	public void setValorTotal(float valorTotal) {
		ValorTotal = valorTotal;
	}
	public Pedido getPedido() {
		return pedido;
	}
	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public Fornecedor getForn() {
		return fornecedor;
	}
	public void setForn(Fornecedor forn) {
		this.fornecedor = forn;
	}
	
	
}
