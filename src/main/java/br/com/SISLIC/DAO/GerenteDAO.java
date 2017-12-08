package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.SISLIC.model.Gerente;

public class GerenteDAO {

	private Connection con = ConexaoFactory.getConnection();
	
	public Gerente autenticar(String login, String senha) {
			String sql = "SELECT *FROM funcionario WHERE login=? and senha=?";
			
			try(PreparedStatement prepara = con.prepareStatement(sql)){
				prepara.setString(1, login);
				prepara.setString(2, senha);
				ResultSet resultado = prepara.executeQuery();
				
				if(resultado.next()) {
					Gerente gerente = new Gerente();
					
					gerente.setCodFunc(resultado.getInt("id_funcionario"));
					gerente.setNome(resultado.getString("nome"));
					gerente.setTelefone(resultado.getString("telefone"));
					gerente.setLogin(resultado.getString("login"));
					gerente.setSenha(resultado.getString("senha"));
					gerente.setCargo(resultado.getString("cargo"));
					
					//PEGAR OS PEDIDOS
					PedidoDAO pedidoDAO = new PedidoDAO();
					gerente.setPedidosAberto(pedidoDAO.buscarTodosPedidosAberto());
					gerente.setPedidosFechados(pedidoDAO.buscarTodosPedidosFechados());
					gerente.setPedidosPendentes(pedidoDAO.buscarTodosPedidosPendentes());
					
					//
					//PEGAR O SETOR E OS PEDIDOS DELE
					/*SetorDAO setorDAO = new SetorDAO();		
					gerente.setSetor(setorDAO.buscarPorId(resultado.getInt("id_setor")));*/
					prepara.close();
					
					if(gerente.getCargo().equals("gerente"))
						return gerente;
				}			
			}catch(SQLException e) {
				e.printStackTrace();			
			}
			return null;
	}
}
