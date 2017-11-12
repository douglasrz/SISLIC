package br.com.SISLIC.model;

import java.util.ArrayList;

public class Setor {

	private int id; 
	private String nome;
	private ArrayList<Pedido> pedidos;
	
	public int getId() {
		return id;
	}
	public void setId(int codigoSetor) {
		this.id = codigoSetor;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public ArrayList<Pedido> getPedidos() {
		return pedidos;
	}
	public void setPedidos(ArrayList<Pedido> pedidos) {
		this.pedidos = pedidos;
	}
}
