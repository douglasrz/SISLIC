package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.SISLIC.model.ItemPedido;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;




public class PedidoDAO {
	
	private Connection con = ConexaoFactory.getConnection();

		
	public Produto buscarProduto(ItemPedido itemPedido) {
		int id = itemPedido.getId_produto();
		String sql = "SELECT *FROM produto WHERE id_produto=?";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			if(resultado.next()) {
				Produto produtoRetorno = new Produto();
				produtoRetorno.setId(id);
				produtoRetorno.setNome(resultado.getString("nome"));
				produtoRetorno.setDescricao(resultado.getString("descricao"));	
				produtoRetorno.setQuantidade(itemPedido.getQuantidade());
				//PEGAR A CATEGORIA
				CategoriaDAO categoriaDAO = new CategoriaDAO();
				produtoRetorno.setCategoria(categoriaDAO.buscaPeloId(resultado.getInt("id_categoria")));
				return produtoRetorno;
			}				
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Pedido buscarPedido(int id) {
		
		String sql = "SELECT *FROM pedido WHERE id_pedido=?";		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			if(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(id);
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getString("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getString("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR OS Itens
				ArrayList<ItemPedido> lista = buscaItemPedido(id);
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				for(ItemPedido p: lista) {
					produtos.add(buscarProduto(p));
				}
				
				//RETORNO SOMENTE SE ESTIVER AUTORIZADO PELO GERENTE				
				pedidoRetorno.setProdutos(produtos);
				if(pedidoRetorno.isAutorizado()) {
					return pedidoRetorno;
				}else return null;
			}				
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Pedido> buscarTodosPedidos() {
		
			ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
			String sql = "SELECT *FROM pedido";		
			
			try(PreparedStatement preparar = con.prepareStatement(sql)){
				ResultSet resultado = preparar.executeQuery();
				while(resultado.next()) {
					Pedido pedidoRetorno = new Pedido();
					pedidoRetorno.setId(resultado.getInt("id_pedido"));
					pedidoRetorno.setNome(resultado.getString("nome"));
					pedidoRetorno.setDataLancamento(resultado.getString("data_lancamento"));
					pedidoRetorno.setDataLimite(resultado.getString("data_limite"));
					pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
					pedidoRetorno.setDescricao(resultado.getString("descricao"));
					pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
					
					//PEGAR OS Itens
					ArrayList<ItemPedido> lista = buscaItemPedido(resultado.getInt("id_pedido"));
					//PEGAR OS PRODUTOS PELA LISTA DE ITENS
					ArrayList<Produto> produtos = new ArrayList<Produto>();
					for(ItemPedido p: lista) {
						produtos.add(buscarProduto(p));						
					}
					pedidoRetorno.setProdutos(produtos);
					
					//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
					if(pedidoRetorno.isAutorizado())
						pedidos.add(pedidoRetorno);
				}	
				return pedidos;
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return pedidos;
		}
	
	public ArrayList<ItemPedido> buscaItemPedido(int idPedido){
		
		ArrayList<ItemPedido> lista = new ArrayList<ItemPedido>();
		String sql = "SELECT *FROM item_pedido WHERE id_pedido=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idPedido);
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {				
				ItemPedido retorno = new ItemPedido();
				retorno.setId(resultado.getInt("id_item_pedido"));
				retorno.setId_pedido(idPedido);
				retorno.setId_produto(resultado.getInt("id_produto"));
				retorno.setQuantidade(resultado.getInt("quantidade"));
				retorno.setPrecoUnit(resultado.getInt("preco"));	
				
				lista.add(retorno);	
			}
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<Pedido> buscarPorSetor(int idSetor){
		
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE id_setor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idSetor);
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {				
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getString("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getString("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR OS Itens
				ArrayList<ItemPedido> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				//PEGAR OS PRODUTOS PELA LISTA DE ITENS
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				for(ItemPedido p: ItensPedido) {
					produtos.add(buscarProduto(p));						
				}
				pedidoRetorno.setProdutos(produtos);
				
				//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
				if(pedidoRetorno.isAutorizado())
					lista.add(pedidoRetorno);
			}
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public ArrayList<Pedido> buscarPedentesSetor(int idSetor){
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE id_setor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idSetor);
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {				
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getString("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getString("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR OS Itens
				ArrayList<ItemPedido> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				//PEGAR OS PRODUTOS PELA LISTA DE ITENS
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				for(ItemPedido p: ItensPedido) {
					produtos.add(buscarProduto(p));						
				}
				pedidoRetorno.setProdutos(produtos);
				
				//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
				if(!pedidoRetorno.isAutorizado())
					lista.add(pedidoRetorno);
			}
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
}
