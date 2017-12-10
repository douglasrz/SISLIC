package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import br.com.SISLIC.model.Penalidade;
import br.com.SISLIC.model.Produto;

public class PenalidadeDAO {
	
	private Connection con;
	
	public ArrayList<Penalidade> buscarForn(int id) {
		con = ConexaoFactory.getConnection();
		ArrayList<Penalidade> lista= new ArrayList<Penalidade>();	
		String sql = "SELECT *FROM log_penalidade WHERE id_fornecedor=?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();//Para retorna os registro				
			//PERCORRE CADA RESGISTRO A CADA LAÇO DO WHILE
			while(resultado.next()) {//next vai para o proximo registro e retorna true se existir
				
				Penalidade penalidade = new Penalidade();
				penalidade.setIdfornecedor(id);
				penalidade.setIdfuncionario(resultado.getInt("id_funcionario"));
				penalidade.setDescricao(resultado.getString("descricao"));
				penalidade.setValor(resultado.getInt("valor"));
				penalidade.setId_pedido(resultado.getInt("id_pedido"));
				penalidade.setData(resultado.getString("data_penal"));
				penalidade.setMotivo(resultado.getString("motivo"));
				penalidade.setNomePedido(resultado.getString("nome_pedido"));
				
				
				//Adicionando na lista
				lista.add(penalidade);
			}	
			con.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public boolean atribuirNoLog(int valor, String motivo, String descricao, int idFornecedor, int idFuncionario, String pedido) {
		con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO log_penalidade(id_fornecedor, id_funcionario, descricao, valor, motivo, data_penal, nome_pedido) VALUES(?,?,?,?,?,?,?)";
		
		java.util.Date dataUtil = new java.util.Date();
		java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, idFornecedor);
			preparar.setInt(2, idFuncionario);
			preparar.setString(3, descricao);
			preparar.setInt(4, valor);
			preparar.setString(5, motivo);
			preparar.setDate(6, dataSql);
			preparar.setString(7, pedido);
			preparar.execute();
			
			preparar.close();
			con.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
}
