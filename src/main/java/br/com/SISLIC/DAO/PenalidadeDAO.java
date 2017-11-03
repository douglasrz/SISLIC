package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import br.com.SISLIC.model.Penalidade;

public class PenalidadeDAO {
	
	private Connection con = ConexaoFactory.getConnection();
	
	public ArrayList<Penalidade> buscarForn(int id) {
		
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
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
}
