package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import br.com.SISLIC.model.Setor;

public class SetorDAO {

	private Connection con = ConexaoFactory.getConnection();
	
	public Setor buscarPorId(int id) {
		String sql = "SELECT *FROM setor WHERE id_setor = ?";
				
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {
				Setor setor = new Setor();				
				setor.setId(id);
				setor.setNome(resultado.getString("nome"));				
				
				//BUSCAR OS PEDIDOS DESSE SETOR
				PedidoDAO pedidoDAO= new PedidoDAO();
				setor.setPedidos(pedidoDAO.buscarPorSetor(id));
				prepara.close();
				return setor;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}
		return null;
	}

}
