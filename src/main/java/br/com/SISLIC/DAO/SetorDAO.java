package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import br.com.SISLIC.model.Setor;

public class SetorDAO {

	//private Connection con;
	
	public Setor buscarPorId(int id) {
		Connection con = ConexaoFactory.getConnection();
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
				//con.close();
				return setor;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Setor buscarSomenteOsetor(int id) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM setor WHERE id_setor = ?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {
				Setor setor = new Setor();				
				setor.setId(id);
				setor.setNome(resultado.getString("nome"));	
				prepara.close();
				//con.close();
				return setor;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Setor buscarSomenteOsetorPeloNome(String nome) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM setor WHERE nome = ?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, nome);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {
				Setor setor = new Setor();				
				setor.setId(Integer.parseInt(resultado.getString("id_setor")));
				setor.setNome(resultado.getString("nome"));	
				prepara.close();
				//con.close();
				return setor;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public boolean cadastrar(String nome) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO setor(nome) VALUES(?)";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, nome);
			prepara.executeQuery();
			prepara.close();
			//con.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
