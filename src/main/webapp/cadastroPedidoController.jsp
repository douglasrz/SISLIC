<%@ page import="br.com.SISLIC.DAO.CategoriaDAO"%>
<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){

		if(request.getSession().getAttribute("categoria")==null) {
			CategoriaDAO catDAO = new CategoriaDAO();
			request.getSession().setAttribute("categorias", catDAO.buscarTodasEForn());
		}
		request.getRequestDispatcher("WEB-INF/cadastroPedido.jsp").forward(request, response);
	
	}else{
		//MÉTODO POST
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
		
			if(acao.equals("cadastrarPedido")) {
				//DADOS GERAIS DO PEDIDO
				Pedido pedido = new Pedido();
				pedido.setNome((String) request.getAttribute("nomePedido"));
				pedido.setDescricao((String) request.getAttribute("descricaoPedido"));
				pedido.setDataLimite((Date) request.getAttribute("dataLimite"));
				System.out.println("NOME DO PEDIDO"+pedido.getNome());
				System.out.println("DESCRICAO DO PEDIDO"+pedido.getDescricao());
				//PEGAR DATA ATUAL
				java.util.Date dataUtil = new java.util.Date();
				java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
				pedido.setDataLancamento(dataSql);
				
				//PEGAR CATEGORIA
				String nomeCategoria = (String) request.getAttribute("categoria");
				CategoriaDAO catDAO = new CategoriaDAO();
				Categoria categoria = catDAO.buscaPeloNome(nomeCategoria);
				
				//PRODUTOS
				int quantProdutos = (int) request.getAttribute("totalProdutos");
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				
				for(int i=1; i<=quantProdutos; i++) {
					Produto produto = new Produto();
					produto.setQuantidade((int) request.getAttribute("quant"+i));
					produto.setNome((String) request.getAttribute("nome"+i));
					produto.setDescricao((String) request.getAttribute("descricaoProduto"+i));
					produto.setCategoria(categoria);
					produtos.add(produto);
				}
				pedido.setProdutos(produtos);
				
				//VERIFICO SE É GERENTE OU FUNCIONARIO E AUTORIZO
				if(request.getSession().getAttribute("gerAutenticado")!=null){
					pedido.setAutorizado(true);
					pedido.setId_funcionario(((Gerente) request.getSession().getAttribute("gerAutenticado")).getCodFunc());
					pedido.setIdSetor(((Gerente) request.getSession().getAttribute("gerAutenticado")).getSetor().getId());
				}else {
					pedido.setAutorizado(false);
					pedido.setId_funcionario(((Funcionario) request.getSession().getAttribute("funAutenticado")).getCodFunc());
					pedido.setIdSetor(((Funcionario) request.getSession().getAttribute("funAutenticado")).getSetor().getId());
				}
				
				//CADASTRAR NO BANCO
				PedidoDAO pedidoDAO = new PedidoDAO();
				if(pedidoDAO.cadastrarPedidoProdutoItensPedido(pedido)) {
					((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
					response.getWriter().print("<script> window.alert('Pedido cadastrado com sucesso!'); location.href='gerentePedidos.jsp';</script>");					
				}
			}
		}	
	}

	
	
	
%>