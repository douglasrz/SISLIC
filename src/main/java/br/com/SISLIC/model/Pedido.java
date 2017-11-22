package br.com.SISLIC.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class Pedido implements Serializable{
	
	private int id;
	private Date dataLancamento;
	private Date dataLimite;
	private ArrayList<Produto> produtos;
	private int id_funcionario;
	private Lance lance;
	private String nome;
	private String descricao;
	private boolean autorizado;
	private boolean statusAberto;
	
	public boolean status() {
		java.util.Date dataUtil = new java.util.Date();
		java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
		int resul = this.dataLimite.compareTo(dataSql);
		//SE RETORNAR MENOR OU IGUAL A ZERO SIGNIFICA QUE O PEDIDO DO LANCE AINDA ESTÁ ABERTO
		if(resul <= 0)	
			return false;
		else return true;
	}	
	public boolean isStatusAberto() {
		return statusAberto;
	}
	public void setStatusAberto(boolean statusAberto) {
		this.statusAberto = statusAberto;
	}
	public Date getDataLancamento() {
		return dataLancamento;
	}
	public void setDataLancamento(Date dataLancamento) {
		this.dataLancamento = dataLancamento;
	}
	public Date getDataLimite() {
		return dataLimite;
	}
	public void setDataLimite(Date dataLimite) {
		this.dataLimite = dataLimite;
	}
	public ArrayList<Produto> getProdutos() {
		return produtos;
	}
	public void setProdutos(ArrayList<Produto> produtos) {
		this.produtos = produtos;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_funcionario() {
		return id_funcionario;
	}
	public void setId_funcionario(int id_funcionario) {
		this.id_funcionario = id_funcionario;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public boolean isAutorizado() {
		return autorizado;
	}
	public void setAutorizado(boolean autorizado) {
		this.autorizado = autorizado;
	}
	public Lance getLance() {
		return lance;
	}
	public void setLance(Lance lance) {
		this.lance = lance;
	}
	
	
	
	
}
