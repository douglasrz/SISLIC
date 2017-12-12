package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.SISLIC.model.Funcionario;
import br.com.SISLIC.model.Gerente;

public class GerenteDAO {

	//private Connection con;
	
	public Gerente autenticar(String login, String senha) {
		Connection con = ConexaoFactory.getConnection();
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
					SetorDAO setorDAO = new SetorDAO();		
					gerente.setSetor(setorDAO.buscarSomenteOsetor(resultado.getInt("id_setor")));
					prepara.close();
					//con.close();
					if(gerente.getCargo().equals("gerente"))
						return gerente;
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
	public boolean update(Gerente ger) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "UPDATE funcionario SET nome=?, telefone=?, senha=?, cargo=?, id_setor=? WHERE id_funcionario=?";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, ger.getNome());			
			preparar.setString(2, ger.getTelefone());
			preparar.setString(3, ger.getSenha());
			preparar.setString(4, ger.getCargo());
			preparar.setInt(5, ger.getSetor().getId());
			//condição
			preparar.setInt(6, ger.getCodFunc());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			//con.close();
			return true;
			
		}catch(SQLException e) {
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
