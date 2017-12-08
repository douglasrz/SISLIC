package br.com.SISLIC.model;

import java.util.ArrayList;

public class Gerente {
	
	private int codFunc;
	private String login;
	private String senha;
	private String nome;
	private String telefone;
	private String cargo;
	private Setor setor;
	private ArrayList<Pedido> pedidosAberto = new ArrayList<Pedido>();
	private ArrayList<Pedido> pedidosFechados = new ArrayList<Pedido>();
	private ArrayList<Pedido> pedidosPendentes = new ArrayList<Pedido>();
	
	
	public int getCodFunc() {
		return codFunc;
	}
	public void setCodFunc(int codFunc) {
		this.codFunc = codFunc;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}	
	public String getCargo() {
		return cargo;
	}
	public void setCargo(String cargo) {
		this.cargo = cargo;
	}
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
	public Setor getSetor() {
		return setor;
	}
	public void setSetor(Setor setor) {
		this.setor = setor;
	}
	
	
}
