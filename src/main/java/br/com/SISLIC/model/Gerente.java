package br.com.SISLIC.model;

import java.util.ArrayList;

public class Gerente extends Funcionario{
	
	
	private ArrayList<Pedido> pedidosAberto = new ArrayList<Pedido>();
	private ArrayList<Pedido> pedidosFechados = new ArrayList<Pedido>();
	private ArrayList<Pedido> pedidosPendentes = new ArrayList<Pedido>();
	
	
	
	public ArrayList<Pedido> getPedidosAberto() {
		return pedidosAberto;
	}
	public void setPedidosAberto(ArrayList<Pedido> pedidosAberto) {
		this.pedidosAberto = pedidosAberto;
	}
	public ArrayList<Pedido> getPedidosFechados() {
		return pedidosFechados;
	}
	public void setPedidosFechados(ArrayList<Pedido> pedidosFechados) {
		this.pedidosFechados = pedidosFechados;
	}
	public ArrayList<Pedido> getPedidosPendentes() {
		return pedidosPendentes;
	}
	public void setPedidosPendentes(ArrayList<Pedido> pedidosPendentes) {
		this.pedidosPendentes = pedidosPendentes;
	}
		
	
}
