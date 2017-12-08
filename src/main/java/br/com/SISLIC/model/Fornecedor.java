package br.com.SISLIC.model;

import java.io.Serializable;
import java.util.ArrayList;

import br.com.SISLIC.DAO.FornecedorDAO;
import br.com.SISLIC.DAO.LanceDAO;

public class Fornecedor implements Serializable{
	
	private int id;
	private String login;
	private String senha;
	private String cnpj;
	private String rSocial;
	private String telefone;
	private int pontuacao;
	private String email;
	private ArrayList<Categoria> categorias;
	private ArrayList<Lance> lances;
	private boolean autorizado;
	
	public Fornecedor() {}
	public Fornecedor(String login, String senha, String rSocial, String telefone, String email) {
		super();
		this.login=login;
		this.senha = senha;
		this.rSocial = rSocial;
		this.telefone = telefone;
		this.email = email;
	}
	
	public Fornecedor(String login, String senha, String cnpj, String rSocial, String telefone, String email) {
		super();
		this.login = login;
		this.senha = senha;
		this.cnpj = cnpj;
		this.rSocial = rSocial;
		this.telefone = telefone;
		this.email = email;
	}
	@Override
	public String toString() {
		return "Fornecedor [id=" + id + ", login=" + login + ", senha=" + senha + ", cnpj=" + cnpj + ", rSocial="
				+ rSocial + ", telefone=" + telefone + ", pontuacao=" + pontuacao + ", categorias=" + categorias + "]";
	}
	
	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getrSocial() {
		return rSocial;
	}

	public void setrSocial(String rSocial) {
		this.rSocial = rSocial;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public int getPontuacao() {
		return pontuacao;
	}

	public void setPontuacao(int pontuacao) {
		this.pontuacao = pontuacao;
	}

	public ArrayList<Categoria> getCategorias() {
		return categorias;
	}

	public void setCategorias(ArrayList<Categoria> categorias) {
		this.categorias = categorias;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}
	
	public boolean isAutorizado() {
		return autorizado;
	}
	public void setAutorizado(boolean autorizado) {
		this.autorizado = autorizado;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public ArrayList<Lance> getLances() {
		return lances;
	}
	public void setLances(ArrayList<Lance> lances) {
		this.lances = lances;
	}
	
	

	
}
