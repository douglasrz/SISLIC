package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//CLASSE RESPONSAVEL PELA CONEXAO COM O BANCO
public class ConexaoFactory {
	
	public static Connection getConnection() {
		try {
			Class.forName("org.postgresql.Driver");//For�ando a inicializacao do drive
			return DriverManager.getConnection("jdbc:postgresql://localhost:5432/SISLIC", "postgres","fdro196245");
		}catch(SQLException e) {
			throw new RuntimeException(e);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
}
