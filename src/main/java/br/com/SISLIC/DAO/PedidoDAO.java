package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;




public class PedidoDAO {
	
	private Connection con = ConexaoFactory.getConnection();

		
	public Produto buscarProduto(int id) {
		
		String sql = "SELECT *FROM produto WHERE id_produto=?";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			
			if(resultado.next()) {
				Produto produtoRetorno = new Produto();
				produtoRetorno.setId(id);
				produtoRetorno.setNome(resultado.getString("nome"));
				produtoRetorno.setDescricao(resultado.getString("descricao"));	
				//PEGAR A CATEGORIA
				CategoriaDAO categoriaDAO = new CategoriaDAO();
				produtoRetorno.setCategoria(categoriaDAO.buscaPeloId(resultado.getInt("id_categoria")));
				
				//QUANTIDADE E PREÇO PEGO SOMENTE SER FOR UM ITEMPEDIDO
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
				ArrayList<Produto> lista = buscaItemPedido(id);						
				//RETORNO SOMENTE SE ESTIVER AUTORIZADO PELO GERENTE				
				pedidoRetorno.setProdutos(lista);
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
					
					//PEGAR OS Produtos
					ArrayList<Produto> lista = buscaItemPedido(resultado.getInt("id_pedido"));					
					pedidoRetorno.setProdutos(lista);
					
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
	

	public ArrayList<Produto> buscaItemPedido(int idPedido){
		
		ArrayList<Produto> lista = new ArrayList<Produto>();
		String sql = "SELECT *FROM item_pedido WHERE id_pedido=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idPedido);
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {				
				Produto retorno = new Produto();
				
				//PEGO O PRODUTO COMO SE ELE NÃO FOSSE DE NENHUM PEDIDO
				retorno = buscarProduto(resultado.getInt("id_produto"));
				
				//PEGO A QUANTIDADE, AQUI ELE JÁ É DE ALGUM PEDIDO NA TABELA item_pedido
				retorno.setQuantidade(resultado.getInt("quantidade"));	
				retorno.setIdItemPedido(resultado.getInt("id_item_pedido"));
				
				//E PRECISO PEGAR O PREÇO NA TABELA lance_item_pedido POIS SÓ É NECESSÁRIO O PREÇO QUANDO FOR EFETUADO O LANCE
				retorno = buscaPrecoProduto(retorno);
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
				ArrayList<Produto> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(ItensPedido);
				
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
				ArrayList<Produto> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(ItensPedido);
				
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
	
	//MÉTODO USADO SOMENTE QUANDO O PRODUTO FOR DE UM LANCE JÁ EFETUADO
	public Produto buscaPrecoProduto(Produto produto) {
		
		String sql = "SELECT *FROM lance_item_pedido WHERE id_item_pedido=?";
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, produto.getIdItemPedido());
			ResultSet resultado = preparar.executeQuery();
			
			if(resultado.next()) {
				produto.setPreco(resultado.getInt("valor"));
				return produto;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return produto;
	}
}