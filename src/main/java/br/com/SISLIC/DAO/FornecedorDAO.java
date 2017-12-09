package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.mail.EmailException;

import br.com.SISLIC.model.Categoria;
import br.com.SISLIC.model.Email;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;

public class FornecedorDAO {
	
	private Connection con = ConexaoFactory.getConnection();
	
	public boolean cadastrar(Fornecedor fornecedor) {
		String sql = "INSERT INTO fornecedor(login,razao_social,telefone,cnpj,email,senha,pontuacao) VALUES(?,?,?,?,?,?,0)";
		//md5 criptografa a senha
		try {
			if(buscarLogin(fornecedor.getLogin())) {
				return false;
			}
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, fornecedor.getLogin());
			preparar.setString(2, fornecedor.getrSocial());			
			preparar.setString(3, fornecedor.getTelefone());
			preparar.setString(4, fornecedor.getCnpj());
			preparar.setString(5, fornecedor.getEmail());
			preparar.setString(6, fornecedor.getSenha());			
			
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			return true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean buscarLogin(String login) {
		String sql = "SELECT *FROM fornecedor WHERE login=?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, login);
			ResultSet resultado = prepara.executeQuery();
			if(resultado.next()) {
				prepara.close();
				return true;
			}else {
				prepara.close();
				return false;
			}
		}catch(SQLException e) {
			e.printStackTrace();	
			return false;
		}
	}
		
	public Fornecedor autenticar(String login, String senha) {
		String sql = "SELECT *FROM fornecedor WHERE login=? and senha=?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, login);
			prepara.setString(2, senha);
			ResultSet resultado = prepara.executeQuery();
			
			if(resultado.next()) {
				Fornecedor fornecedor = new Fornecedor();
				fornecedor.setId(resultado.getInt("id_fornecedor"));
				fornecedor.setrSocial(resultado.getString("razao_social"));
				fornecedor.setLogin(resultado.getString("login"));
				fornecedor.setSenha(resultado.getString("senha"));
				fornecedor.setCnpj(resultado.getString("cnpj"));
				fornecedor.setTelefone(resultado.getString("telefone"));				
				fornecedor.setPontuacao(resultado.getInt("pontuacao"));
				fornecedor.setEmail(resultado.getString("email"));
				fornecedor.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR SUAS CATEGORIAS
				CategoriaDAO cateDAO = new CategoriaDAO();				
				fornecedor.setCategorias(cateDAO.buscarPorForn(fornecedor.getId()));
				
				//PEGAR OS LANCES
				prepara.close();
				return fornecedor;
			}			
		}catch(SQLException e) {
			e.printStackTrace();			
		}
		return null;
	}
	
	public boolean updateCad(Fornecedor fornecedor) {
		String sql = "UPDATE fornecedor SET razao_social=?, telefone=?, senha=?, email=? WHERE login=?";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, fornecedor.getrSocial());			
			preparar.setString(2, fornecedor.getTelefone());
			preparar.setString(3, fornecedor.getSenha());
			preparar.setString(4, fornecedor.getEmail());
			//condição
			preparar.setString(5, fornecedor.getLogin());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public void updateSenha(String login, String senha) {
		String sql = "UPDATE fornecedor SET senha=? WHERE login=?";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, senha);			
			preparar.setString(2, login);
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public Fornecedor buscarPorId(int id) {
		String sql = "SELECT *FROM fornecedor WHERE id_fornecedor=?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();
			if(resultado.next()) {
				Fornecedor fornecedor = new Fornecedor();
				fornecedor.setId(resultado.getInt("id_fornecedor"));
				fornecedor.setrSocial(resultado.getString("razao_social"));
				fornecedor.setLogin(resultado.getString("login"));
				fornecedor.setSenha(resultado.getString("senha"));
				fornecedor.setCnpj(resultado.getString("cnpj"));
				fornecedor.setTelefone(resultado.getString("telefone"));				
				fornecedor.setPontuacao(resultado.getInt("pontuacao"));
				fornecedor.setEmail(resultado.getString("email"));
				fornecedor.setAutorizado(resultado.getBoolean("autorizado"));
					
				//PEGAR SUAS CATEGORIAS
				CategoriaDAO cateDAO = new CategoriaDAO();				
				fornecedor.setCategorias(cateDAO.buscarPorForn(fornecedor.getId()));
					
				//PEGAR OS LANCES
				LanceDAO lanceDAO = new LanceDAO();
				fornecedor.setLances(lanceDAO.lancesFornId(fornecedor.getId()));
				prepara.close();	
				return fornecedor;
			}
		}catch(SQLException e) {
			e.printStackTrace();				
		}
		return null;
	}
	public ArrayList<Fornecedor> buscarTodosPendentes() {
		
		ArrayList<Fornecedor> lista = new ArrayList<Fornecedor>();
		String sql = "SELECT *FROM fornecedor WHERE autorizado = false";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {
				Fornecedor retorno = new Fornecedor();
				retorno.setId(resultado.getInt("id_fornecedor"));
				retorno.setLogin(resultado.getString("login"));
				retorno.setrSocial(resultado.getString("razao_social"));
				retorno.setCnpj(resultado.getString("cnpj"));
				retorno.setEmail(resultado.getString("email"));
				retorno.setTelefone(resultado.getString("telefone"));
				retorno.setPontuacao(resultado.getInt("pontuacao"));
				retorno.setAutorizado(false);
				lista.add(retorno);
			}
			preparar.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public ArrayList<Fornecedor> buscarTodosAutorizados() {
		

		ArrayList<Fornecedor> lista = new ArrayList<Fornecedor>();
		String sql = "SELECT *FROM fornecedor WHERE autorizado = true";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {
				Fornecedor retorno = new Fornecedor();
				retorno.setId(resultado.getInt("id_fornecedor"));
				retorno.setLogin(resultado.getString("login"));
				retorno.setrSocial(resultado.getString("razao_social"));
				retorno.setCnpj(resultado.getString("cnpj"));
				retorno.setEmail(resultado.getString("email"));
				retorno.setTelefone(resultado.getString("telefone"));
				retorno.setPontuacao(resultado.getInt("pontuacao"));
				retorno.setAutorizado(false);
				lista.add(retorno);
			}
			preparar.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Fornecedor buscarPorIdSomenteForn(int id) {
		String sql = "SELECT *FROM fornecedor WHERE id_fornecedor=?";
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, id);
			ResultSet resultado = prepara.executeQuery();
			if(resultado.next()) {
				Fornecedor fornecedor = new Fornecedor();
				fornecedor.setId(resultado.getInt("id_fornecedor"));
				fornecedor.setrSocial(resultado.getString("razao_social"));
				fornecedor.setLogin(resultado.getString("login"));
				fornecedor.setSenha(resultado.getString("senha"));
				fornecedor.setCnpj(resultado.getString("cnpj"));
				fornecedor.setTelefone(resultado.getString("telefone"));				
				fornecedor.setPontuacao(resultado.getInt("pontuacao"));
				fornecedor.setEmail(resultado.getString("email"));
				fornecedor.setAutorizado(resultado.getBoolean("autorizado"));
					
				//PEGAR SUAS CATEGORIAS
				CategoriaDAO cateDAO = new CategoriaDAO();				
				fornecedor.setCategorias(cateDAO.buscarPorForn(fornecedor.getId()));					
				
				prepara.close();	
				return fornecedor;
			}
		}catch(SQLException e) {
			e.printStackTrace();				
		}
		return null;
	}
	public boolean atribuirPenalidade(int valor,int idFornecedor) {
		String sql = "UPDATE fornecedor SET pontuacao = pontuacao+? WHERE id_fornecedor = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, valor);
			preparar.setInt(2, idFornecedor);
			preparar.execute();
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean removerPenalidade(int valor,int idFornecedor) {
		String sql = "UPDATE fornecedor SET pontuacao = pontuacao-? WHERE id_fornecedor = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, valor);
			preparar.setInt(2, idFornecedor);
			preparar.execute();
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean excluirCadastroEnotificar(int id, String email) {
		String sql = "DELETE FROM fornecedor WHERE id_fornecedor = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
			preparar.execute();
			preparar.close();
			//NOTIFICAR O FORNECEDOR
			Email notificar = new Email();
			String mensagem = "Seu cadastro foi excluído por motivos maiores, sentimos muito pelo transtorno";
			try {
				notificar.notificacao(mensagem, email);
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean autorizarFornEnotificar(int id, String email) {
		String sql = "UPDATE fornecedor SET autorizado = true WHERE id_fornecedor = ?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
			preparar.execute();
			preparar.close();
			//NOTIFICAR O FORNECEDOR
			Email notificar = new Email();
			String mensagem = "Seu cadastro foi autorizado, navegue no nosso sistema [SISLIC] e aproveite os pedidos de compras.";
			try {
				notificar.notificacao(mensagem, email);
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
