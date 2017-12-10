<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){//M�TODO GET
		
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
		
			if(acao.equals("pedido")) {
				int id = Integer.parseInt(request.getParameter("id"));
				PedidoDAO pedidoDAO = new PedidoDAO();
				Pedido pedido = pedidoDAO.buscarPedidoAberto(id);
				//Pedido pedido = pedidoDAO.buscarPedido(id);			
				request.getSession().setAttribute("pedido", pedido);
				request.getRequestDispatcher("WEB-INF/pedido.jsp").forward(request, response);
			}
		}else {
				if(request.getSession().getAttribute("pedidos")==null) {
					PedidoDAO pedidoDAO = new PedidoDAO();
					ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
					//ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidos();
					//FornecedorDAO
					request.getSession().setAttribute("pedidos", pedidos);
					request.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(request, response);
				}
				else {
					request.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(request, response);
				}				
		}
		
	}else{//M�TODO POST
		
		//VERIFICO SE OS PEDIDOS J� FORAM SETADOS NA SESSAO, CASO POSITIVO N�O PRECISO MAIS PEGAR NO BANCO, ASSIM A NAVEGA�AO FICA MAIS R�PIDA
				//QUANDO EU INSERIR UM NOVO A� QUE EU DEVO ATUALIZAR
				if(request.getSession().getAttribute("pedidos")==null) {
					PedidoDAO pedidoDAO = new PedidoDAO();
					ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
					//FornecedorDAO
					request.getSession().setAttribute("pedidos", pedidos);
					request.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(request, response);
				}else {
					request.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(request, response);
				}
			
	}

%>