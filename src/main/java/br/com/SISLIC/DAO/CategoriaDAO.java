package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;

import br.com.SISLIC.model.Categoria;
import br.com.SISLIC.model.Fornecedor;

public class CategoriaDAO {
	
	///private Connection con;
	
	//EXCLUIR CATEGORIA
	public boolean excluir(int id) {
		Connection con =  ConexaoFactory.getConnection();
		String sql = "DELETE FROM categoria_fornecedor WHERE id_categoria=?";
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
			preparar.execute();
			preparar.close();
			
			return true;
			
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
		return false;
	}
	
	//BUSCAR TODAS AS CATEGORIAS DE UM FORNECEDOR
	public ArrayList<Categoria> buscarPorForn(int idFornecedor){
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria_fornecedor WHERE id_fornecedor=?";
		ArrayList<Integer> lista = new ArrayList<Integer>();
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			preparar.setInt(1, idFornecedor);
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {
				lista.add(resultado.getInt("id_categoria"));
			}
			preparar.close();
		}catch(SQLException e) {
			e.printStackTrace();			
		}
		String sqlcat = "SELECT *FROM categoria WHERE id_categoria=?";
		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		
		try(PreparedStatement prepara = con.prepareStatement(sqlcat)){
			for(int i=0;i<lista.size();i++) {
				prepara.setInt(1, lista.get(i));
				ResultSet resultado = prepara.executeQuery();				
				if(resultado.next()) {
					int id = resultado.getInt("id_categoria");
					String nome = resultado.getString("nome");
					String descricao = resultado.getString("descricao");
					Categoria categoria = new Categoria(id,nome,descricao);
					categorias.add(categoria);
				}
			}
			prepara.close();
			//con.close();
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
		
		return categorias;
	}
	
	/*CADASTRAR UMA CATEGORIA PARA UM FORNECEDOR. PRIMEIRO VERIFICO TODAS AS CATEGORIAS QUE O FORNECEDOR JÁ TEM, AÍ VERIFICO NO FOR SE ELE JA QUE 
	POSSUI UMA COM O NOME IGUAL A ESTA NOVA, CASO POSITIVO EU NÃO CADASTRO ELA. DEPOIS EU VERIFICO SE A CATEGORIA JÁ EXISTE NA EM CATEGORIAS QUE 
	NÃO ESTA ASSOCIADO A ELE, CASO POSITIVO EU SÓ INSIRO NA TABELA categoria_fornecedor. CASO NEGATIVO NOS DOIS CASOS, É INSERIDO NAS DUAS TABELAS*/
	public boolean cadastrarParaForn(Categoria categoria) {		
		
		Categoria resul = buscaPeloNome(categoria.getNome());//PEGO O RESULTADO SE EXISTE A CATEGORIA
		ArrayList<Categoria> categoriasDoForn = buscarPorForn(categoria.getIdFornecedor());//PEGO TODAS AS CATEGORIAS DELE
		boolean catExistente = true;
		
		for(Categoria c: categoriasDoForn) {//VERIFICO SE ALGUMA QUE ELE JÁ POSSUI É IGUAL A ESTA NOVA
			if(c.getNome().equals(categoria.getNome()))
				catExistente = false;
		}
		if(catExistente) {			
			if(resul == null) {
				Connection con =  ConexaoFactory.getConnection();
				String sql = "INSERT INTO categoria (nome,descricao) VALUES(?,?)";
				try {
					PreparedStatement preparar = con.prepareStatement(sql);				
					preparar.setString(1,categoria.getNome());
					preparar.setString(2, categoria.getDescricao());
					preparar.execute();
					preparar.close();
					Categoria categoriaBuscaId = buscaPeloNome(categoria.getNome());
					//con.close();
					return cadCategoriaForn(categoriaBuscaId.getCod(), categoria.getIdFornecedor());
					
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
			}
			return cadCategoriaForn(resul.getCod(), categoria.getIdFornecedor());
		}
		return false;
	}
	
	
	public Categoria buscaPeloNome(String nome) {
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria WHERE nome=?";
		try {
			PreparedStatement preparar = con.prepareStatement(sql);				
			preparar.setString(1,nome);
			ResultSet resultado = preparar.executeQuery();			
			if(resultado.next()) {
				Categoria categoria = new Categoria();
				categoria.setCod(resultado.getInt("id_categoria"));
				categoria.setNome(resultado.getString("nome"));
				categoria.setDescricao(resultado.getString("descricao"));
				preparar.close();
				con.close();
				return categoria;
			}
			//con.close();
			return null;
			
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
	
	public boolean cadCategoriaForn(int id_categoria, int id_fornecedor) {
		Connection con =  ConexaoFactory.getConnection();
		String sql = "INSERT INTO categoria_fornecedor(id_categoria,id_fornecedor) VALUES(?,?)";
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			preparar.setInt(1, id_categoria);
			preparar.setInt(2, id_fornecedor);
			preparar.execute();
			preparar.close();
			//con.close();
			return true;
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
		return false;
	}
	
	public Categoria buscaPeloId(int id) {
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria WHERE id_categoria=?";
		try {
			PreparedStatement preparar = con.prepareStatement(sql);				
			preparar.setInt(1,id);
			ResultSet resultado = preparar.executeQuery();			
			if(resultado.next()) {
				Categoria categoria = new Categoria();
				categoria.setCod(resultado.getInt("id_categoria"));
				categoria.setNome(resultado.getString("nome"));
				categoria.setDescricao(resultado.getString("descricao"));
				preparar.close();
				//con.close();
				return categoria;
			}
			//fechanco a conexao com o banco
			preparar.close();
			//con.close();
			return null;
			
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
	
	public ArrayList<Categoria> buscarTodasEForn(){
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria";
		ArrayList<Categoria> lista = new ArrayList<Categoria>();
		
		try{
			PreparedStatement prepara = con.prepareStatement(sql);
			ResultSet resultado = prepara.executeQuery();
			
			while(resultado.next()) {
				Categoria cat = new Categoria();
				cat.setCod(resultado.getInt("id_categoria"));
				cat.setNome(resultado.getString("nome"));
				cat.setDescricao("descricao");
				cat.setFornecedores(buscarFornPelaCategoria(cat.getCod()));
				lista.add(cat);
			}	
			prepara.close();
			//con.close();
			return lista;
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
	public ArrayList<Fornecedor> buscarFornPelaCategoria(int idCategoria){
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria_fornecedor WHERE id_categoria=?";
		ArrayList<Fornecedor> lista = new ArrayList<Fornecedor>();
		FornecedorDAO fornDAO = new FornecedorDAO();
		Fornecedor forn = new Fornecedor();
		try(PreparedStatement prepara = con.prepareStatement(sql)){
			prepara.setInt(1, idCategoria);
			ResultSet resultado = prepara.executeQuery();
			while(resultado.next()) {
				forn = fornDAO.buscarPorId(resultado.getInt("id_Fornecedor"));
				if(forn.equals(null))
					lista.add(forn);
			}	
			prepara.close();
			//con.close();
			return lista;
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

	public boolean cadastrarCat(Categoria categoria) {
		
		if(buscaPeloNome(categoria.getNome()) == null){
			Connection con =  ConexaoFactory.getConnection();
			String sql = "INSERT INTO categoria (nome,descricao) VALUES(?,?)";
			try {
				PreparedStatement preparar = con.prepareStatement(sql);				
				preparar.setString(1,categoria.getNome());
				preparar.setString(2, categoria.getDescricao());
				preparar.execute();
				preparar.close();
				//con.close();
				return true;
			
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
		}
		return false;
	}
public ArrayList<Categoria> buscarTodas(){
		
		Connection con =  ConexaoFactory.getConnection();
		String sql = "SELECT *FROM categoria";
		ArrayList<Categoria> lista = new ArrayList<Categoria>();
		
		try{
			PreparedStatement prepara = con.prepareStatement(sql);
			ResultSet resultado = prepara.executeQuery();
			
			while(resultado.next()) {
				Categoria cat = new Categoria();
				cat.setCod(resultado.getInt("id_categoria"));
				cat.setNome(resultado.getString("nome"));
				cat.setDescricao("descricao");
				lista.add(cat);
			}	
			prepara.close();
			//con.close();
			return lista;
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
}
