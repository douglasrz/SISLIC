package br.com.SISLIC.model;

public class Categoria {

	private int cod;
	private String nome;
	private String descricao;
	private int idFornecedor;
	
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
	
	
	
}
