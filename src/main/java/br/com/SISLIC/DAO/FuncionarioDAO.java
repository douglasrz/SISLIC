package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.SISLIC.model.Funcionario;

public class FuncionarioDAO {

	
	private Connection con = ConexaoFactory.getConnection();
	
	public Funcionario autenticar(String login, String senha) {
			String sql = "SELECT *FROM funcionario WHERE login=? and senha=?";
			
			try(PreparedStatement prepara = con.prepareStatement(sql)){
				prepara.setString(1, login);
				prepara.setString(2, senha);
				ResultSet resultado = prepara.executeQuery();
				
				if(resultado.next()) {
					Funcionario funcionario = new Funcionario();
					
					funcionario.setCodFunc(resultado.getInt("id_funcionario"));
					funcionario.setNome(resultado.getString("nome"));
					funcionario.setTelefone(resultado.getString("telefone"));
					funcionario.setLogin(resultado.getString("login"));
					funcionario.setSenha(resultado.getString("senha"));
					funcionario.setCargo(resultado.getString("cargo"));
					
					//PEGAR O SETOR E OS PEDIDOS DELE
					SetorDAO setorDAO = new SetorDAO();		
					funcionario.setSetor(setorDAO.buscarPorId(resultado.getInt("id_setor")));
					
					return funcionario;
				}			
			}catch(SQLException e) {
				e.printStackTrace();			
			}
			return null;
	}

}
