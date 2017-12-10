package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.mail.EmailException;

import br.com.SISLIC.model.Email;
import br.com.SISLIC.model.Funcionario;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;

public class FuncionarioDAO {

	
	private Connection con;
	
	public Funcionario autenticar(String login, String senha) {
			con = ConexaoFactory.getConnection();
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
					con.close();
					return funcionario;
				}
				con.close();
			}catch(SQLException e) {
				e.printStackTrace();			
			}
			
			return null;
	}
	public Funcionario buscarPorId(int id) {
		con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM funcionario WHERE id_funcionario=?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {
				Funcionario funcionario = new Funcionario();
				
				funcionario.setCodFunc(resultado.getInt("id_funcionario"));
				funcionario.setNome(resultado.getString("nome"));
				funcionario.setTelefone(resultado.getString("telefone"));
				funcionario.setLogin(resultado.getString("login"));
				funcionario.setSenha(resultado.getString("senha"));
				funcionario.setCargo(resultado.getString("cargo"));
				
				//PEGAR O SETOR
				SetorDAO setorDAO = new SetorDAO();		
				funcionario.setSetor(setorDAO.buscarSomenteOsetor(resultado.getInt("id_setor")));
				con.close();
				return funcionario;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}
		return null;
	}
	public ArrayList<Funcionario> buscarTodosExcetoGerente(){
		con = ConexaoFactory.getConnection();
		ArrayList<Funcionario> funcionarios = new ArrayList<Funcionario>();
		String sql = "SELECT *FROM funcionario WHERE cargo!='gerente'";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {
				Funcionario funcionario = new Funcionario();
				
				funcionario.setCodFunc(resultado.getInt("id_funcionario"));
				funcionario.setNome(resultado.getString("nome"));
				funcionario.setTelefone(resultado.getString("telefone"));
				funcionario.setLogin(resultado.getString("login"));
				funcionario.setSenha(resultado.getString("senha"));
				funcionario.setCargo(resultado.getString("cargo"));
				
				//PEGAR O SETOR
				SetorDAO setorDAO = new SetorDAO();		
				funcionario.setSetor(setorDAO.buscarSomenteOsetor(resultado.getInt("id_setor")));
				
				funcionarios.add(funcionario);
			}	
			preparar.close();
			con.close();
			return funcionarios;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return funcionarios;
	}
	public boolean update(Funcionario fun) {
		con = ConexaoFactory.getConnection();
		String sql = "UPDATE funcionario SET nome=?, telefone=?, senha=?, cargo=?, id_setor=? WHERE id_funcionario=?";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, fun.getNome());			
			preparar.setString(2, fun.getTelefone());
			preparar.setString(3, fun.getSenha());
			preparar.setString(4, fun.getCargo());
			preparar.setInt(5, fun.getSetor().getId());
			//condição
			preparar.setInt(6, fun.getCodFunc());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			con.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean excluirCadastro(int id) {
		con = ConexaoFactory.getConnection();
		String sql = "DELETE FROM funcionario WHERE id_funcionario = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
			preparar.execute();
			preparar.close();
			con.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean cadastrar(Funcionario fun) {
		con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO funcionario(login,nome,telefone,cargo,id_setor,senha) VALUES(?,?,?,?,?,?)";
		try {
			if(buscarLogin(fun.getLogin())) {
				return false;
			}
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, fun.getLogin());
			preparar.setString(2, fun.getNome());			
			preparar.setString(3, fun.getTelefone());
			preparar.setString(4, fun.getCargo());
			preparar.setInt(5, fun.getSetor().getId());
			preparar.setString(6, fun.getSenha());				
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			con.close();
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean buscarLogin(String login) {
		con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM funcionario WHERE login=?";		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, login);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {	
				con.close();
				return true;
			}		
			con.close();	
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}
}
