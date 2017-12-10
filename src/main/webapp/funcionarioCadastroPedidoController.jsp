<%@page import="java.util.Date"%>
<%@ page import="br.com.SISLIC.DAO.CategoriaDAO"%>
<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){
		if(request.getSession().getAttribute("categoria")==null) {
			CategoriaDAO catDAO = new CategoriaDAO();
			request.getSession().setAttribute("categorias", catDAO.buscarTodas());
		}
		request.getRequestDispatcher("WEB-INF/funcionarioCadastroPedido.jsp").forward(request, response);
	
	}else{
		//MÉTODO POST
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
		
			if(acao.equals("cadastrarPedido")) {
				int quantProdutos = Integer.parseInt(request.getParameter("quantProduto"));
				//DADOS GERAIS DO PEDIDO
				Pedido pedido = new Pedido();
				pedido.setNome((String) request.getParameter("nomepedido"));
				pedido.setDescricao((String) request.getParameter("descricaoPedido"));			
				
				String dataLimite = request.getParameter("datalimite");
				//PEGAR CATEGORIA
				String nomeCategoria = (String) request.getParameter("categoria");
				CategoriaDAO catDAO = new CategoriaDAO();
				Categoria categoria = catDAO.buscaPeloNome(nomeCategoria);
				//PRODUTOS
				ArrayList<Produto> produtos = new ArrayList<Produto>();				
				for(int i=1; i<=quantProdutos; i++) {
					Produto produto = new Produto();
					produto.setQuantidade(Integer.parseInt(request.getParameter("quant"+i)));
					produto.setNome((String) request.getParameter("nome"+i));
					produto.setDescricao((String) request.getParameter("descricaoProduto"+i));
					produto.setCategoria(categoria);
					produtos.add(produto);
				}
				pedido.setProdutos(produtos);
				
				pedido.setAutorizado(false);
				pedido.setId_funcionario(((Funcionario) request.getSession().getAttribute("funAutenticado")).getCodFunc());
				pedido.setIdSetor(((Funcionario) request.getSession().getAttribute("funAutenticado")).getSetor().getId());
								
				//CADASTRAR NO BANCO
				PedidoDAO pedidoDAO = new PedidoDAO();
				if(pedidoDAO.cadastrarPedidoProdutoItensPedido(pedido, dataLimite)){
					session.setAttribute("pedidospendentes", pedidoDAO.buscarTodosPedidosPendentes());
					response.getWriter().print("<script> window.alert('Pedido cadastrado com sucesso!'); location.href='funcionarioPedidosController.jsp?acao=pedidospendentes';</script>");					
				}else{
					response.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente mais tarde.'); location.href='funcionarioCadastroPedidoController.jsp';</script>");	
				}
			}
		}
	}
		

	
	
	
%>