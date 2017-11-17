package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Produto;

public class LanceDAO {
	
private Connection con = ConexaoFactory.getConnection();
	
	public boolean cadastrar(Lance lance) {
		String sql = "INSERT INTO lance(valor_total,id_pedido,id_fornecedor,data) VALUES(?,?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setFloat(1,lance.getTotal() );
			preparar.setInt(2,lance.getPedido().getId() );			
			preparar.setInt(3, lance.getIdfornecedor());
			preparar.setString(4,lance.getData());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public void busca(int idFornecedor, int Pedido) {
		String sql = "SELECT *FROM lance WHERE id_fornecedor = ? AND id_pedido = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			/*
			//Substitui o ? pelo dado do usuario
			preparar.setFloat(1,lance.getTotal() );
			preparar.setInt(2,lance.getIdPedido() );			
			preparar.setInt(3, lance.getIdfornecedor());
			preparar.setDate(4, (Date) lance.getData());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			return true;*/
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void cadastrarItensLance(Lance lance) {
		String sql = "INSERT INTO lance_item_pedido(id_lance, id_tem_pedido,valor) VALUES(?,?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			
			preparar.setFloat(1,lance.getId());
			preparar.setInt(2,lance.getPedido().getId());			
			preparar.setInt(3, lance.getIdfornecedor());
			preparar.setDate(4, (Date) lance.getData());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			return true;*/
			
		}
	}
	}
		
}
