package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.SISLIC.model.Categoria;
import br.com.SISLIC.model.Fornecedor;

public class FornecedorDAO {
	
	private Connection con = ConexaoFactory.getConnection();
	
	public void cadastrar(Fornecedor fornecedor) {
		String sql = "INSERT INTO fornecedor(login,razao_social,telefone,cnpj,email,senha,pontuacao) VALUES(?,?,?,?,?,md5(?),0)";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setString(1, fornecedor.getLogin());
			preparar.setString(2, fornecedor.getrSocial());			
			preparar.setString(3, fornecedor.getTelefone());
			preparar.setString(3, fornecedor.getCnpj());
			preparar.setString(4, fornecedor.getEmail());
			preparar.setString(5, fornecedor.getSenha());
			//execurtando o comando sql no banco de dados
			preparar.execute();
			//fechanco a conexao com o banco
			preparar.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	public Fornecedor autenticar(Fornecedor forn) {
		String sql = "SELECT *FROM fornecedor WHERE login=? and senha=?";
		
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setString(1, forn.getLogin());
			prepara.setString(2, forn.getSenha());
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
				
				//PEGAR SUAS CATEGORIAS
				CategoriaDAO cateDAO = new CategoriaDAO();				
				fornecedor.setCategorias(cateDAO.buscarPorForn(fornecedor.getId()));
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
}
