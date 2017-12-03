package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.mail.EmailException;

import br.com.SISLIC.model.Email;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;




public class PedidoDAO {
	
	private Connection con = ConexaoFactory.getConnection();

		
	public Pedido buscarPedido(int id) {
		
		String sql = "SELECT *FROM pedido WHERE id_pedido=?";		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			if(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(id);
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				pedidoRetorno.setStatusAberto(pedidoRetorno.status());//VEJO SE AINDA ESTÁ ABERTO O PEDIDO, PARA NÃO MOSTRAR PARA O USUARIO
				//PEGAR OS Itens
				ArrayList<Produto> lista = buscaItemPedido(id);						
				//RETORNO SOMENTE SE ESTIVER AUTORIZADO PELO GERENTE				
				pedidoRetorno.setProdutos(lista);
				if(pedidoRetorno.isAutorizado()) {
					preparar.close();
					return pedidoRetorno;
				}else return null;
			}				
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Pedido buscarPedidoAberto(int id) {
			
			String sql = "SELECT *FROM pedido WHERE id_pedido=?";		
			try(PreparedStatement preparar = con.prepareStatement(sql)){	
				preparar.setInt(1, id);
				ResultSet resultado = preparar.executeQuery();
				if(resultado.next()) {
					Pedido pedidoRetorno = new Pedido();
					pedidoRetorno.setId(id);
					pedidoRetorno.setNome(resultado.getString("nome"));
					pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
					pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
					pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
					pedidoRetorno.setDescricao(resultado.getString("descricao"));
					pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
					pedidoRetorno.setStatusAberto(pedidoRetorno.status());//VEJO SE AINDA ESTÁ ABERTO O PEDIDO, PARA NÃO MOSTRAR PARA O USUARIO
					//PEGAR OS Itens
					ArrayList<Produto> lista = buscaItemPedido(id);						
					//RETORNO SOMENTE SE ESTIVER AUTORIZADO PELO GERENTE				
					pedidoRetorno.setProdutos(lista);
					if(pedidoRetorno.isAutorizado() && pedidoRetorno.isStatusAberto()) {
						preparar.close();
						return pedidoRetorno;
					}else {
						preparar.close();
						return null;
					}
				}				
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return null;
	}
	public ArrayList<Pedido> buscarTodosPedidosAberto(){
		
		ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				pedidoRetorno.setStatusAberto(pedidoRetorno.status());
				//PEGAR OS Produtos
				ArrayList<Produto> lista = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(lista);
				
				//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
				if(pedidoRetorno.isAutorizado() && pedidoRetorno.isStatusAberto())
					pedidos.add(pedidoRetorno);
			}	
			preparar.close();
			return pedidos;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return pedidos;
	}
	
	public ArrayList<Pedido> buscarTodosPedidos() {
		
			ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
			String sql = "SELECT *FROM pedido";		
			
			try(PreparedStatement preparar = con.prepareStatement(sql)){
				ResultSet resultado = preparar.executeQuery();
				while(resultado.next()) {
					Pedido pedidoRetorno = new Pedido();
					pedidoRetorno.setId(resultado.getInt("id_pedido"));
					pedidoRetorno.setNome(resultado.getString("nome"));
					pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
					pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
					pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
					pedidoRetorno.setDescricao(resultado.getString("descricao"));
					pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
					pedidoRetorno.setStatusAberto(pedidoRetorno.status());
					//PEGAR OS Produtos
					ArrayList<Produto> lista = buscaItemPedido(resultado.getInt("id_pedido"));					
					pedidoRetorno.setProdutos(lista);
					
					//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
					if(pedidoRetorno.isAutorizado())
						pedidos.add(pedidoRetorno);
				}	
				preparar.close();
				return pedidos;
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return pedidos;
		}
	

	public ArrayList<Produto> buscaItemPedido(int idPedido){
		
		ArrayList<Produto> lista = new ArrayList<Produto>();
		String sql = "SELECT *FROM item_pedido WHERE id_pedido=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idPedido);
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {				
				Produto retorno = new Produto();
				
				//PEGO O PRODUTO COMO SE ELE NÃO FOSSE DE NENHUM PEDIDO
				ProdutoDAO produtoDAO = new ProdutoDAO();
				retorno = produtoDAO.buscarProduto(resultado.getInt("id_produto"));
				
				//PEGO A QUANTIDADE, AQUI ELE JÁ É DE ALGUM PEDIDO NA TABELA item_pedido
				retorno.setQuantidade(resultado.getInt("quantidade"));	
				retorno.setIdItemPedido(resultado.getInt("id_item_pedido"));
				
				//E PRECISO PEGAR O PREÇO NA TABELA lance_item_pedido POIS SÓ É NECESSÁRIO O PREÇO QUANDO FOR EFETUADO O LANCE
				retorno = produtoDAO.buscaPrecoProduto(retorno);
				lista.add(retorno);	
			}
			preparar.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<Pedido> buscarPorSetor(int idSetor){
		
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE id_setor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idSetor);
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {				
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR OS Itens
				ArrayList<Produto> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(ItensPedido);
				
				//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
				if(pedidoRetorno.isAutorizado())
					lista.add(pedidoRetorno);
			}
			preparar.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	public ArrayList<Pedido> buscarPedentesSetor(int idSetor){
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE id_setor=?";
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, idSetor);
			ResultSet resultado = preparar.executeQuery();
			
			while(resultado.next()) {				
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				
				//PEGAR OS Itens
				ArrayList<Produto> ItensPedido = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(ItensPedido);
				
				//PEGAR SOMENTE O QUE FORAM AUTORIZADOS PELO GERENTE
				if(!pedidoRetorno.isAutorizado())
					lista.add(pedidoRetorno);
			}
			preparar.close();
			return lista;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
	public ArrayList<Pedido> buscarTodosPedidosFechados() {
		ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				pedidoRetorno.setStatusAberto(pedidoRetorno.status());
				//PEGAR OS Produtos
				ArrayList<Produto> lista = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(lista);
				
				//PEGAR SOMENTE O QUE NÃO ESTÃO EM ABERTO
				if(!pedidoRetorno.isStatusAberto())
					pedidos.add(pedidoRetorno);
			}	
			preparar.close();
			return pedidos;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return pedidos;
	}
	
	public ArrayList<Pedido> buscarTodosPedidosPendentes() {
		
		ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE autorizado = false ";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			ResultSet resultado = preparar.executeQuery();
			while(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(resultado.getInt("id_pedido"));
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				pedidoRetorno.setStatusAberto(pedidoRetorno.status());
				//PEGAR OS Produtos
				ArrayList<Produto> lista = buscaItemPedido(resultado.getInt("id_pedido"));
				pedidoRetorno.setProdutos(lista);
				
				pedidos.add(pedidoRetorno);
			}	
			preparar.close();
			return pedidos;
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return pedidos;
	}
	//ESTE MÉTODO PEGA O PEDIDO FECHADO, ABERTO OU PEDENTE, DEPENDE SOMENTE DO ID
	public Pedido buscarPedidoSemRestrição(int id) {
		
		String sql = "SELECT *FROM pedido WHERE id_pedido=?";		
		try(PreparedStatement preparar = con.prepareStatement(sql)){	
			preparar.setInt(1, id);
			ResultSet resultado = preparar.executeQuery();
			if(resultado.next()) {
				Pedido pedidoRetorno = new Pedido();
				pedidoRetorno.setId(id);
				pedidoRetorno.setNome(resultado.getString("nome"));
				pedidoRetorno.setDataLancamento(resultado.getDate("data_lancamento"));
				pedidoRetorno.setDataLimite(resultado.getDate("data_limite"));
				pedidoRetorno.setId_funcionario(resultado.getInt("id_funcionario"));
				pedidoRetorno.setDescricao(resultado.getString("descricao"));
				pedidoRetorno.setAutorizado(resultado.getBoolean("autorizado"));
				pedidoRetorno.setStatusAberto(pedidoRetorno.status());//VEJO SE AINDA ESTÁ ABERTO O PEDIDO, PARA NÃO MOSTRAR PARA O USUARIO
				//PEGAR OS Itens
				ArrayList<Produto> lista = buscaItemPedido(id);						
				pedidoRetorno.setProdutos(lista);
				preparar.close();
				return pedidoRetorno;
				
			}				
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public boolean autorizarPedido(int id) {
		
		String sql = "UPDATE pedido SET autorizado = true WHERE id_pedido=?";
		//md5 criptografa a senha
		try {
			PreparedStatement preparar = con.prepareStatement(sql);
			//Substitui o ? pelo dado do usuario
			preparar.setInt(1, id);
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
	
	//ESTE MÉTODO VAI APAGAR item_pedido, lance_item_pedido, lances, pedido E VAI NOTIFICAR CADA FORNECEDOR QUE FIZERAM LANCES NESSE PEDIDO
	public boolean cancelarPedidoElances(int id) {
		
		LanceDAO lanceDAO = new LanceDAO();
		FornecedorDAO forDAO = new FornecedorDAO();
		ArrayList<Lance> lances = lanceDAO.buscarPorIdPedido(id); 
		
		if(!lances.isEmpty()) {
			Email notificar = new Email();
			String mensagem = "O pedido <"+lances.get(0).getPedido().getNome()+"> foi cancelado pela empresa, logo seu lance não será considerado. Obrigado pela compreensão!";
			
			//NOTIFICAR OS FORNECEDORES E REMOVER OS LANCES
			try {
				for(Lance l: lances) {		
					lanceDAO.deleteLance(l.getId());//DELETANDO CADA LANCES PARA ESSE PEDIDO
					notificar.cancelamentoPedido(mensagem, l.getForn().getEmail());
					
				}
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//APGAR OS ITENS DO PEDIDO
		if(!apagarItensPedido(id)) {
			return false;
		}
		
		String sql = "DELETE FROM pedido WHERE id_pedido=?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
			preparar.execute();
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private boolean apagarItensPedido(int idPedido) {
		
		String sql = "DELETE FROM item_pedido WHERE id_pedido=?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, idPedido);
			preparar.execute();
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean cadastrarPedidoProdutoItensPedido(Pedido pedido) {
		
		String sql = "INSERT INTO pedido(data_lancamento, data_limite, id_funcionario, nome, descricao, id_setor, autorizado) VALUES(?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setDate(1, pedido.getDataLancamento());
			preparar.setDate(2, pedido.getDataLimite());
			preparar.setInt(3, pedido.getId_funcionario());
			preparar.setString(4, pedido.getNome());
			preparar.setString(5, pedido.getDescricao());
			preparar.setInt(6, pedido.getIdSetor());
			preparar.setBoolean(7, pedido.isAutorizado());
			preparar.execute();
			preparar.close();
			
			//CADASTRAR OS PRODUTOS
			ProdutoDAO prodDAO = new ProdutoDAO();
			for(Produto p: pedido.getProdutos()) {
				if(!prodDAO.cadastrarProduto(p))
					return false;
			}
			//CADASTRAR item_pedido
			if(!cadastrarTodosItemPedido(pedido)) {
				return false;
			}
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean cadastrarTodosItemPedido(Pedido pedido) {
		
		String sql = "INSERT INTO item_pedido(quantidade, id_produto, id_pedido) VALUES(?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			for(Produto p: pedido.getProdutos()) {
				preparar.setInt(1, p.getQuantidade());
				preparar.setInt(2, p.getId());
				preparar.setInt(3, pedido.getId());
				preparar.execute();
			}
			preparar.close();
			return true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}