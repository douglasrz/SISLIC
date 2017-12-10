<%@ page import="br.com.SISLIC.DAO.LanceDAO"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
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
					request.getSession().setAttribute("todosLances",lanceDAO.todosLances());
				}
				request.getRequestDispatcher("WEB-INF/funcionarioLances.jsp").forward(request, response);
			}else {
				if(acao.equals("lancesdopedido")) {					
					int id = Integer.parseInt(request.getParameter("id"));
					if(session.getAttribute("lances")==null){
						request.getSession().setAttribute("lances", lanceDAO.buscarPorIdPedido(id));
					}
					request.getRequestDispatcher("WEB-INF/funcionarioLancesPedido.jsp").forward(request, response);
				}else {
					if(acao.equals("lance")) {
						int id = Integer.parseInt(request.getParameter("id"));
						request.setAttribute("lance", lanceDAO.buscarPorId(id));
						request.getRequestDispatcher("WEB-INF/funcionarioLance.jsp").forward(request, response);
					}
				}
			}
		}
	}else{
		
	}		
						

%>