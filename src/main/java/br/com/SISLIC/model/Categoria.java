package br.com.SISLIC.model;

import java.io.Serializable;
import java.util.ArrayList;

public class Categoria implements Serializable{

	private int cod;
	private String nome;
	private String descricao;
	private int idFornecedor;
	private ArrayList<Fornecedor> fornecedores;
	
	public Categoria() {}
	
	public Categoria(int cod, String nome, String descricao) {
		super();
		this.cod = cod;
		this.nome = nome;
		this.descricao = descricao;
	}
	public int getCod() {
		return cod;
	}
	public void setCod(int cod) {
		this.cod = cod;
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

	public int getIdFornecedor() {
		return idFornecedor;
	}

	public void setIdFornecedor(int idFornecedor) {
		this.idFornecedor = idFornecedor;
	}

	public ArrayList<Fornecedor> getFornecedores() {
		return fornecedores;
	}

	public void setFornecedores(ArrayList<Fornecedor> fornecedores) {
		this.fornecedores = fornecedores;
	}
	
	
	
}
