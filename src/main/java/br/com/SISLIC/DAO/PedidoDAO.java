package br.com.SISLIC.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.apache.commons.mail.EmailException;

import br.com.SISLIC.model.Email;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;




public class PedidoDAO {
	
	//private Connection con;

		
	public Pedido buscarPedido(int id) {
		Connection con = ConexaoFactory.getConnection();
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
					//con.close();
					return pedidoRetorno;
				}else {
					//con.close();
					return null;
				}
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
	
	public Pedido buscarPedidoAberto(int id) {
		Connection con = ConexaoFactory.getConnection();
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
						//con.close();
						return pedidoRetorno;
					}else {
						//con.close();
						preparar.close();
						return null;
					}
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
	public ArrayList<Pedido> buscarTodosPedidosAberto(){
		Connection con = ConexaoFactory.getConnection();
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
			//con.close();
			return pedidos;
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
		return pedidos;
	}
	
	public ArrayList<Pedido> buscarTodosPedidos() {
		Connection con = ConexaoFactory.getConnection();
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
				//con.close();
				return pedidos;
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
			return pedidos;
		}
	

	public ArrayList<Produto> buscaItemPedido(int idPedido){
		Connection con = ConexaoFactory.getConnection();
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
		return lista;
	}
	public ArrayList<Pedido> buscarPorSetor(int idSetor){
		Connection con = ConexaoFactory.getConnection();
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
		return lista;
	}
	
	public ArrayList<Pedido> buscarPedentesSetor(int idSetor){
		Connection con = ConexaoFactory.getConnection();
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
		return lista;
	}
	public ArrayList<Pedido> buscarTodosPedidosFechados() {
		Connection con = ConexaoFactory.getConnection();
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
			//con.close();
			return pedidos;
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
		return pedidos;
	}
	
	public ArrayList<Pedido> buscarTodosPedidosPendentes() {
		
		Connection con = ConexaoFactory.getConnection();
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
			//con.close();
			return pedidos;
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
		return pedidos;
	}
	//ESTE MÉTODO PEGA O PEDIDO FECHADO, ABERTO OU PEDENTE, DEPENDE SOMENTE DO ID
	public Pedido buscarPedidoSemRestrição(int id) {
		Connection con = ConexaoFactory.getConnection();
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
				con.close();
				return pedidoRetorno;
				
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
	public boolean autorizarPedido(int id) {
		Connection con = ConexaoFactory.getConnection();
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
	
	//ESTE MÉTODO VAI APAGAR item_pedido, lance_item_pedido, lances, pedido E VAI NOTIFICAR CADA FORNECEDOR QUE FIZERAM LANCES NESSE PEDIDO
	public boolean cancelarPedidoElances(int id) {
		LanceDAO lanceDAO = new LanceDAO();
		ArrayList<Lance> lances = lanceDAO.buscarPorIdPedido(id); 
		
		if(!lances.isEmpty()) {
			Email notificar = new Email();
			String mensagem = "O pedido <"+lances.get(0).getPedido().getNome()+"> foi cancelado pela empresa, logo seu lance não será considerado. Obrigado pela compreensão!";
			
			//NOTIFICAR OS FORNECEDORES E REMOVER OS LANCES
			try {
				for(Lance l: lances) {		
					lanceDAO.deleteLance(l.getId());//DELETANDO CADA LANCES PARA ESSE PEDIDO
					notificar.notificacao(mensagem, l.getForn().getEmail());					
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
		Connection con = ConexaoFactory.getConnection();	
		String sql = "DELETE FROM pedido WHERE id_pedido=?";		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, id);
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
	
	private boolean apagarItensPedido(int idPedido) {
		
		Connection con = ConexaoFactory.getConnection();
		String sql = "DELETE FROM item_pedido WHERE id_pedido=?";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql);	
			preparar.setInt(1, idPedido);
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
	public boolean cadastrarPedidoProdutoItensPedido(Pedido pedido, String dataLimite) {	
		
		Connection con = ConexaoFactory.getConnection();
		//CADASTRAR OS PRODUTOS
		ProdutoDAO prodDAO = new ProdutoDAO();
		int idProduto;
		for(Produto p: pedido.getProdutos()) {
			idProduto = prodDAO.cadastrarProdutoEretornaId(p);
			if(idProduto == 0) {//PRECISO ADICIONAR NO BANCO E SETAR O ID EM SEGUIDA PARA SER USADO NO CADASTRAR item_pedido
				return false;
			}
			p.setId(idProduto);
		}		
		//CADASTRAR O PEDIDO
		int id = cadastrarSomentePedidoEretornaId(pedido, dataLimite);
		if(id == 0) {
			return false;
		}
		pedido.setId(id);
		
		//CADASTRAR item_pedido	
		if(!cadastrarTodosItemPedido(pedido)) {
			return false;
		}
		return true;
	}
	
	public boolean cadastrarTodosItemPedido(Pedido pedido) {
		
		Connection con = ConexaoFactory.getConnection();
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
	public ArrayList<Pedido> buscarPorIdFun(int id){
		Connection con = ConexaoFactory.getConnection();
		ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
		String sql = "SELECT *FROM pedido WHERE id_funcionario =? ";		
		
		try(PreparedStatement preparar = con.prepareStatement(sql)){
			preparar.setInt(1, id);
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
			//con.close();
			return pedidos;
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
		return pedidos;
	}
	private int cadastrarSomentePedidoEretornaId(Pedido pedido, String dataLimite) {
		Connection con = ConexaoFactory.getConnection();
		//PEGAR DATA ATUAL
		java.util.Date dataUtil = new java.util.Date();
		java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
		pedido.setDataLancamento(dataSql);		
				
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date parsed = null;
		try {
			parsed = format.parse(dataLimite);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		java.sql.Date datasqlLimite = new java.sql.Date(parsed.getTime());		
				
		String sql = "INSERT INTO pedido(data_lancamento, data_limite, id_funcionario, nome, descricao, id_setor, autorizado) VALUES(?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement preparar = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			preparar.setDate(1, pedido.getDataLancamento());
			preparar.setDate(2, datasqlLimite);
			preparar.setInt(3, pedido.getId_funcionario());
			preparar.setString(4, pedido.getNome());
			preparar.setString(5, pedido.getDescricao());
			preparar.setInt(6, pedido.getIdSetor());
			preparar.setBoolean(7, pedido.isAutorizado());
			preparar.execute();
			ResultSet rs = preparar.getGeneratedKeys();
			int id = 0;
			if (rs.next()) {
			    id = rs.getInt("id_pedido");
			}
			preparar.close();
			//con.close();
			return id;
			
		}catch(SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}