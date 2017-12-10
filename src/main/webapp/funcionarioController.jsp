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
			if(acao.equals("pedidosPendentes")) {
				
				Funcionario fun = (Funcionario) request.getSession().getAttribute("funAutenticado");
				ArrayList<Pedido> pedidosPendentes = pedidoDAO.buscarPedentesSetor(fun.getSetor().getId());
				
				request.getSession().setAttribute("pedidosPendentes", pedidosPendentes);
				request.getRequestDispatcher("WEB-INF/funPedidosPendentes.jsp").forward(request, response);
			}
			
		}else{
			request.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(request, response);
		}
	}else{
		//MÉTODO POST
		//PARA USAR A MESMA PÁGINA JSP NO VIEW
		//request.getSession().setAttribute("tipoPedido", "pedidosabertos");
		request.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(request, response);
		//request.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(request, response);
	}
	%>