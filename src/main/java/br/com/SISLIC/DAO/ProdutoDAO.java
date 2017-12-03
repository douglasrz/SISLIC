package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.SISLIC.model.Produto;

public class ProdutoDAO {
	
	private Connection con = ConexaoFactory.getConnection();

	
	public Produto buscarProduto(int id) {
		
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
				return produtoRetorno;
			}				
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	//MÉTODO USADO SOMENTE QUANDO O PRODUTO FOR DE UM LANCE JÁ EFETUADO
	public Produto buscaPrecoProduto(Produto produto) {
			
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
			}catch(SQLException e) {
				e.printStackTrace();
			}
			
			return produto;
	}
		
	public boolean cadastrarProduto(Produto produto) {
		
		String sql = "INSERT INTO produto(nome, descricao, id_categoria) VALUES(?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setString(1, produto.getNome());
			preparar.setString(2, produto.getDescricao());
			preparar.setInt(3, produto.getCategoria().getCod());
			preparar.execute();
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
