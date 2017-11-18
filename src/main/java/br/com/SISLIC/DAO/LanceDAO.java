package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;
public class LanceDAO {
	
private Connection con = ConexaoFactory.getConnection();
	
	public boolean cadastrar(Lance lance) {
		String sql = "INSERT INTO lance(valor_total, id_pedido, id_fornecedor, data, taxa_entrega) VALUES(?,?,?,?,?)";		
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setFloat(1,lance.getTotal() );
			preparar.setInt(2,lance.getPedido().getId());			
			preparar.setInt(3, lance.getIdfornecedor());
			preparar.setDate(4,lance.getData());
			preparar.setFloat(5, lance.getTaxaEntrega());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//DEPOIS DE SALVAR O PEDIDO, EU PRECISO PEGAR O ID DELE GERADO PELO PRORPIO BANCO
			//VAI BUGAR SE O MESMO FORNECEDOR EFETUAR O MESMO LANCE NO MESMO DIA 
			lance = buscarIdLance(lance);//vai retornar o mesmo só que com o seu id			
			//AGORA PRECISO ADD OS PREÇOS NA TABELA lance_item_pedido
			cadastrarItensLance(lance);
			//fechanco a conexao com o banco
			preparar.close();
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public Lance buscarIdLance(Lance lance) {
		String sql = "SELECT *FROM lance WHERE id_fornecedor = ? AND id_pedido = ? AND data = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			
			preparar.setInt(1,lance.getIdfornecedor());
			preparar.setInt(2,lance.getPedido().getId());			
			preparar.setDate(3, lance.getData());
			
			ResultSet resultado = preparar.executeQuery();
			if(resultado.next()) {
				lance.setId(resultado.getInt("id_lance"));
				return lance;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lance;
	}
	public void cadastrarItensLance(Lance lance) {
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
						
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	public ArrayList<Lance>	lancesFornId(int idForn){
		
		ArrayList<Lance> lista = new ArrayList<Lance>();
		String sql = "SELECT *FROM lance WHERE id_fornecedor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idForn);
			ResultSet resultado = preparar.executeQuery();
			PedidoDAO pedidoDAO = new PedidoDAO();			
			while(resultado.next()) {
				Lance retorno = new Lance();
				retorno.setId(resultado.getInt("id_lance"));
				retorno.setTotal(resultado.getFloat("valor_total"));
				retorno.setData(resultado.getDate("data"));
				retorno.setIdfornecedor(resultado.getInt("id_fornecedor"));
				retorno.setTaxaEntrega(resultado.getFloat("taxa_entrega"));				
				//PEGAR O PEDIDO
				retorno.setPedido(pedidoDAO.buscarPedido(resultado.getInt("id_pedido")));
				lista.add(retorno);
			}
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
}
