package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RecuperacaoSenhaDAO {

	private Connection con = ConexaoFactory.getConnection();
	//VERIFICAR SE EXISTE ALGUM USUARIO COM ESSE LOGIN E SENHA
	public boolean verifEmailLoginForn(String login, String email) {
		
		String sql = "SELECT *FROM fornecedor WHERE login=? AND email=?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, login);
			prepara.setString(2, email);
			ResultSet resultado = prepara.executeQuery();
			if(resultado.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
