<%@page import="java.util.ArrayList"%>
<%@page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	PedidoDAO pedidoDAO = new PedidoDAO();
	//MÉTODO GET
	if(request.getMethod().equals("GET")){
		
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
			
			if(acao.equals("pedidosabertos")) {
				if(session.getAttribute("pedidosabertos") == null || ((ArrayList) session.getAttribute("pedidosabertos")).size() == 0) {
					session.setAttribute("pedidosabertos", pedidoDAO.buscarTodosPedidosAberto());
				}
				//PARA USAR A MESMA PÁGINA JSP NO VIEW
				request.getSession().setAttribute("tipoPedido", "pedidosabertos");
				request.getRequestDispatcher("WEB-INF/funcionarioPedidos.jsp").forward(request, response);
			
			}else {
				if(acao.equals("pedidospendentes")) {
					if(session.getAttribute("pedidospendentes") == null || ((ArrayList) session.getAttribute("pedidospendentes")).size() == 0) {
						session.setAttribute("pedidospendentes", pedidoDAO.buscarTodosPedidosPendentes());
					}
					request.getSession().setAttribute("tipoPedido", "pedidospendentes");
					request.getRequestDispatcher("WEB-INF/funcionarioPedidos.jsp").forward(request, response);
				
				}else {
					if(acao.equals("pedidosfechados")) {
						if(session.getAttribute("pedidosfechados") == null || ((ArrayList) session.getAttribute("pedidosfechados")).size() == 0) {
							session.setAttribute("pedidosfechados", pedidoDAO.buscarTodosPedidosFechados());
						}
						request.getSession().setAttribute("tipoPedido", "pedidosfechados");
						request.getRequestDispatcher("WEB-INF/funcionarioPedidos.jsp").forward(request, response);
					}else {
						if(acao.equals("pedido")) {
							int id = Integer.parseInt(request.getParameter("id"));	
							request.getSession().setAttribute("pedido", pedidoDAO.buscarPedidoSemRestrição(id));
							request.getRequestDispatcher("WEB-INF/funcionarioPedido.jsp").forward(request, response);
						}
					}
				}
			}
		}
	}else{
		//MÉTODO POST
		if(session.getAttribute("pedidosabertos") == null || ((ArrayList) session.getAttribute("pedidosabertos")).size() == 0) {
			session.setAttribute("pedidosabertos", pedidoDAO.buscarTodosPedidosAberto());
		}
		//PARA USAR A MESMA PÁGINA JSP NO VIEW
		request.getSession().setAttribute("tipoPedido", "pedidosabertos");
		request.getRequestDispatcher("WEB-INF/funcionarioPedidos.jsp").forward(request, response);
	}
	%>