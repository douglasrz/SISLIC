package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;

public class LanceDAO {
	
private Connection con;
	
	public boolean cadastrar(Lance lance) {
		con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO lance(valor_total, id_pedido, id_fornecedor, data, taxa_entrega) VALUES(?,?,?,?,?)";		
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			//Substitui o ? pelo dado do usuario
			preparar.setFloat(1,lance.getValorTotal() );
			preparar.setInt(2,lance.getPedido().getId());			
			preparar.setInt(3, lance.getForn().getId());
			preparar.setDate(4,lance.getData());
			preparar.setFloat(5, lance.getTaxaEntrega());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			ResultSet rs = preparar.getGeneratedKeys();
			int id = 0;
			if (rs.next()) {
			    id = rs.getInt("id_lance");
			}
			lance.setId(id); 	
			//AGORA PRECISO ADD OS PREÇOS NA TABELA lance_item_pedido
			cadastrarItensLance(lance);
			//fechanco a conexao com o banco
			preparar.close();
			con.close();
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public void cadastrarItensLance(Lance lance) {
		con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO lance_item_pedido(id_lance, id_item_pedido, valor) VALUES(?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			preparar.setInt(1,lance.getId());
			
			//GRAVO TODOS OS VALORES DOS PRODUTOS DO MESMO LANCE
			for(Produto p: lance.getPedido().getProdutos()) {		
				preparar.setInt(2, lance.getPedido().getProdutos().get(0).getIdItemPedido());			
				preparar.setFloat(3, p.getPreco());
				//execurtando o comando sql no banco de dados
				preparar.execute();
			}
			
			//fechanco a conexao com o banco
			preparar.close();
			con.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	public ArrayList<Lance>	lancesFornId(int idForn){
		
		con = ConexaoFactory.getConnection();
		ArrayList<Lance> lista = new ArrayList<Lance>();
		String sql = "SELECT *FROM lance WHERE id_fornecedor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idForn);
			ResultSet resultado = preparar.executeQuery();
			PedidoDAO pedidoDAO = new PedidoDAO();	
			//FornecedorDAO fornDAO = new FornecedorDAO();
			while(resultado.next()) {
				Lance retorno = new Lance();
				retorno.setId(resultado.getInt("id_lance"));
				retorno.setValorTotal(resultado.getFloat("valor_total"));
				retorno.setData(resultado.getDate("data"));
				retorno.setTaxaEntrega(resultado.getFloat("taxa_entrega"));	
				
				//PEGAR O FORNECEDOR
				//retorno.setForn(fornDAO.buscarPorId(idForn));
				//PEGAR O PEDIDO
				retorno.setPedido(pedidoDAO.buscarPedido(resultado.getInt("id_pedido")));
				lista.add(retorno);
			}
			preparar.close();
			con.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public Lance buscarPorId(int id) {
		con = ConexaoFactory.getConnection();
		String sql = "SELECT * FROM lance WHERE id_lance = ?";
		try (PreparedStatement preparar = con.prepareStatement(sql)){
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();		
			if(resultado.next()) {
					Lance lance = new Lance();
					lance.setId(id);
					lance.setValorTotal(resultado.getFloat("valor_total"));
					lance.setData(resultado.getDate("data"));
					lance.setTaxaEntrega(resultado.getFloat("taxa_entrega"));
					

					FornecedorDAO fornDAO = new FornecedorDAO();
					//PEGAR O FORNECEDOR
					lance.setForn(fornDAO.buscarPorId(resultado.getInt("id_fornecedor")));
					//PEGAR O PEDIDO
					PedidoDAO pedidoDAO = new PedidoDAO();
					Pedido pedido = pedidoDAO.buscarPedido(resultado.getInt("id_pedido"));
					
					//PEGAR OS VALORES OFERTADO NESTE LANCE DOS PRODUTOS
					ArrayList<Produto> produtos = new ArrayList<Produto>();
					ProdutoDAO prodDAO = new ProdutoDAO();
					for(Produto p: pedido.getProdutos()) {
						produtos.add(prodDAO.buscaPrecoProduto(p));						
					}
					pedido.setProdutos(produtos);
					lance.setPedido(pedido);
					preparar.close();
					con.close();
					return lance;
				}				
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
	}
	public boolean deleteLance(int idLance) {//APAGO A TABELA LANCE E LANCE_ITEM_PEDIDO
		
		if(!deleteLanceItens(idLance)) {//APAGO LOGO OS ITENS DO LANCE (lance_item_pedido)
			return false;//se não conseguiu apagar os itens então já retorno sem apagar o lance
		}
		con = ConexaoFactory.getConnection();
		String sql = "DELETE FROM lance WHERE id_lance = ?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, idLance);	
			prepara.execute();
			prepara.close();
			con.close();
			return true;
		} catch (SQLException e) {			
			e.printStackTrace();
			return false;
		}
	}
	private boolean deleteLanceItens(int idLance) {
		con = ConexaoFactory.getConnection();
		String sql = "DELETE FROM lance_item_pedido WHERE id_lance = ?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, idLance);			
			prepara.execute(); 
			prepara.close();
			con.close();
			return true;
		} catch (SQLException e) {			
			e.printStackTrace();
			return false;
		}
	}
	public ArrayList<Lance>	buscarPorIdPedido(int idPedido){
		con = ConexaoFactory.getConnection();
		ArrayList<Lance> lista = new ArrayList<Lance>();
		String sql = "SELECT *FROM lance WHERE id_pedido=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idPedido);
			ResultSet resultado = preparar.executeQuery();
			PedidoDAO pedidoDAO = new PedidoDAO();	
			FornecedorDAO fornDAO = new FornecedorDAO();		
			while(resultado.next()) {
				Lance retorno = new Lance();
				retorno.setId(resultado.getInt("id_lance"));
				retorno.setValorTotal(resultado.getFloat("valor_total"));
				retorno.setData(resultado.getDate("data"));
				retorno.setTaxaEntrega(resultado.getFloat("taxa_entrega"));	
				//PEGAR O FORNECEDOR
				retorno.setForn(fornDAO.buscarPorId(resultado.getInt("id_fornecedor")));
				//PEGAR O PEDIDO
				retorno.setPedido(pedidoDAO.buscarPedido(resultado.getInt("id_pedido")));
				lista.add(retorno);
			}
			preparar.close();
			con.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<Lance>	todosLances(){
		con = ConexaoFactory.getConnection();
		ArrayList<Lance> lista = new ArrayList<Lance>();
		String sql = "SELECT *FROM lance";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			PedidoDAO pedidoDAO = new PedidoDAO();	
			FornecedorDAO fornDAO = new FornecedorDAO();
			while(resultado.next()) {
				Lance retorno = new Lance();
				retorno.setId(resultado.getInt("id_lance"));
				retorno.setValorTotal(resultado.getFloat("valor_total"));
				retorno.setData(resultado.getDate("data"));
				retorno.setTaxaEntrega(resultado.getFloat("taxa_entrega"));		
				//retorno.setIdfornecedor(resultado.getInt("id_fornecedor"));
				
				//PEGAR O FORNECEDOR
				retorno.setForn(fornDAO.buscarPorIdSomenteForn(resultado.getInt("id_fornecedor")));
				//PEGAR O PEDIDO
				retorno.setPedido(pedidoDAO.buscarPedido(resultado.getInt("id_pedido")));
				lista.add(retorno);
			}
			preparar.close();
			con.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public boolean deletetodossLancesDoForn(int idForn) {
		con = ConexaoFactory.getConnection();
		String sql = "DELETE FROM lance WHERE id_fornecedor = ?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, idForn);	
			prepara.execute();
			prepara.close();
			con.close();
			return true;
		} catch (SQLException e) {			
			e.printStackTrace();
			return false;
		}
	}
	
}
