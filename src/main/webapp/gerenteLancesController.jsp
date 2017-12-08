<%@ page import="br.com.SISLIC.DAO.LanceDAO"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	LanceDAO lanceDAO = new LanceDAO(); 
	if(request.getMethod().equals("GET")){
		
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
			
			if(acao.equals("lances")) {
				lanceDAO.todosLances();
				if(request.getSession().getAttribute("todosLances") == null) {
					request.getSession().setAttribute("todosLances",lanceDAO.todosLances());//ERRO
				}
				request.getRequestDispatcher("WEB-INF/gerenteLances.jsp").forward(request, response);
			}else {
				if(acao.equals("lancesdopedido")) {					
					int id = Integer.parseInt(request.getParameter("id"));
					request.getSession().setAttribute("lances", lanceDAO.buscarPorIdPedido(id));
					request.getRequestDispatcher("WEB-INF/gerenteLancesPedido.jsp").forward(request, response);
				}else {
					if(acao.equals("lance")) {
						int id = Integer.parseInt(request.getParameter("id"));
						request.setAttribute("lance", lanceDAO.buscarPorId(id));
						request.getRequestDispatcher("WEB-INF/gerenteLance.jsp").forward(request, response);
					}
				}
			}
		}
	}else{
		
	}		
						

%>