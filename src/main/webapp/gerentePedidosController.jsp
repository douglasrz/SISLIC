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
			
			if(acao.equals("pedidosaberto")) {
				if(((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto() == null || ((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto().size() == 0) {
					((Gerente) request.getSession().getAttribute("gerAutenticado")).setPedidosAberto(pedidoDAO.buscarTodosPedidosAberto());
				}
				//PARA USAR A MESMA PÁGINA JSP NO VIEW
				request.getSession().setAttribute("tipoPedido", "pedidosabertos");
				request.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(request, response);
			
			}else {
				if(acao.equals("pedidospendentes")) {
					if(((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosPendentes()== null || ((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().size() == 0) {
						((Gerente) request.getSession().getAttribute("gerAutenticado")).setPedidosPendentes(pedidoDAO.buscarTodosPedidosPendentes());
						//req.getSession().setAttribute("pedidosaberto", pedidos);
					}
					request.getSession().setAttribute("tipoPedido", "pedidospendentes");
					request.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(request, response);
				
				}else {
					if(acao.equals("pedidosfechados")) {
						if(((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosFechados() == null || ((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosFechados().size() == 0) {
							((Gerente) request.getSession().getAttribute("gerAutenticado")).setPedidosFechados(pedidoDAO.buscarTodosPedidosFechados());
							//req.getSession().setAttribute("pedidosaberto", pedidos);
						}
						String tipoPedido = "pedidosfechados";
						request.getSession().setAttribute("tipoPedido", tipoPedido);
						request.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(request, response);
					}else {
						if(acao.equals("pedido")) {
							int id = Integer.parseInt(request.getParameter("id"));	
							request.getSession().setAttribute("pedido", pedidoDAO.buscarPedidoSemRestrição(id));
							request.getRequestDispatcher("WEB-INF/gerentePedido.jsp").forward(request, response);
						}
						if(acao.equals("cancelar")) {
							int id = Integer.parseInt(request.getParameter("id"));
							if(pedidoDAO.cancelarPedidoElances(id)) {
								((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
								((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().clear();		
								response.getWriter().print("<script> window.alert('Pedido cancelado com sucesso!'); location.href='gerentePedidosController.jsp?acao=pedidosaberto';</script>");
							}
						}else {
							if(acao.equals("autorizar")) {
								int id = Integer.parseInt(request.getParameter("id"));
								if(pedidoDAO.autorizarPedido(id)) {
									//SETAR COMO NULL PARA ELE ATUALIZAR COM ESTE NOVO AUTORIZADO
									((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
									((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().clear();									
									response.getWriter().print("<script> window.alert('Pedido autorizado com sucesso!'); location.href='gerentepedidos.do?acao=pedidosaberto';</script>");
								}
							}
						}
					}
				}
			}
		}
	}else{
		//MÉTODO POST
		if(((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto()== null || ((Gerente) request.getSession().getAttribute("gerAutenticado")).getPedidosAberto().size() == 0) {
			((Gerente) request.getSession().getAttribute("gerAutenticado")).setPedidosAberto(pedidoDAO.buscarTodosPedidosAberto());
			//req.getSession().setAttribute("pedidosaberto", pedidos);
		}
		//PARA USAR A MESMA PÁGINA JSP NO VIEW
		request.getSession().setAttribute("tipoPedido", "pedidosabertos");
		request.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(request, response);
	}
	%>