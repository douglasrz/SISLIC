package br.com.SISLIC.model;


public class Lance {

	private int id;
	private float total;
	private Pedido pedido;
	private int Idfornecedor;
	private String data;
	private float taxaEntrega;
	private ItemPedido itempedido;
	
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}	
	public Pedido getPedido() {
		return pedido;
	}
	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}
	public int getIdfornecedor() {
		return Idfornecedor;
	}
	public void setIdfornecedor(int idfornecedor) {
		Idfornecedor = idfornecedor;
	}
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
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public ItemPedido getItempedido() {
		return itempedido;
	}
	public void setItempedido(ItemPedido itempedido) {
		this.itempedido = itempedido;
	}
	
	
	
}
