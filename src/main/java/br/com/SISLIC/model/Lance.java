package br.com.SISLIC.model;

public class Lance {

	private float total;
	private Pedido pedidoComLances;
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public Pedido getPedidoComLances() {
		return pedidoComLances;
	}
	public void setPedidoComLances(Pedido pedidoComLances) {
		this.pedidoComLances = pedidoComLances;
	}
	
	
}
