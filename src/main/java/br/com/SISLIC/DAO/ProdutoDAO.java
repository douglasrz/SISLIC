package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import br.com.SISLIC.model.Produto;

public class ProdutoDAO {
	
	//private Connection con;

	
	public Produto buscarProduto(int id) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM produto WHERE id_produto=?";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			
			if(resultado.next()) {
				Produto produtoRetorno = new Produto();
				produtoRetorno.setId(id);
				produtoRetorno.setNome(resultado.getString("nome"));
				produtoRetorno.setDescricao(resultado.getString("descricao"));	
				//PEGAR A CATEGORIA
				CategoriaDAO categoriaDAO = new CategoriaDAO();
				produtoRetorno.setCategoria(categoriaDAO.buscaPeloId(resultado.getInt("id_categoria")));
				
				//QUANTIDADE E PREÇO PEGO SOMENTE SER FOR UM ITEMPEDIDO
				preparar.close();
				//con.close();
				return produtoRetorno;
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
	//MÉTODO USADO SOMENTE QUANDO O PRODUTO FOR DE UM LANCE JÁ EFETUADO
	public Produto buscaPrecoProduto(Produto produto) {
		Connection con = ConexaoFactory.getConnection();
			String sql = "SELECT *FROM lance_item_pedido WHERE id_item_pedido=?";
			try(PreparedStatement preparar = con.prepareStatement(sql)){	
				preparar.setInt(1, produto.getIdItemPedido());
				ResultSet resultado = preparar.executeQuery();
				
				if(resultado.next()) {
					produto.setPreco(resultado.getInt("valor"));
					preparar.close();
					return produto;
				}
				preparar.close();
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
			
			return produto;
	}
		
	public int cadastrarProdutoEretornaId(Produto produto) {
		
		//VERIFICO SE JÁ EXISTE UM PRODUTO COM ESTE NOME
		int id = buscaIdProduto(produto.getNome());
		if(id != 0){
			return id;
		}
		Connection con = ConexaoFactory.getConnection();
		String sql = "INSERT INTO produto(nome, descricao, id_categoria) VALUES(?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			preparar.setString(1, produto.getNome());
			preparar.setString(2, produto.getDescricao());
			preparar.setInt(3, produto.getCategoria().getCod());
			preparar.execute();
			ResultSet rs = preparar.getGeneratedKeys();
			if (rs.next()) {
			    id = rs.getInt("id_produto");
			}
			preparar.close();
			//con.close();
			return id;
			
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
		return 0;
	}
	
	private int buscaIdProduto(String nome) {
		Connection con = ConexaoFactory.getConnection();
		String sql = "SELECT *FROM produto WHERE nome=?";
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setString(1, nome);
			ResultSet resultado = preparar.executeQuery();
			
			if(resultado.next()) {
				int retorno = resultado.getInt("id_produto");
				preparar.close();
				return retorno;
			}
			preparar.close();
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
		return 0;
	}
}
