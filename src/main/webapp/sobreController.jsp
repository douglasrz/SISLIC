<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	
	if(session.getAttribute("forAutenticado")!=null){
		request.getRequestDispatcher("WEB-INF/fornecedorSobre.jsp").forward(request, response);	
	}else{
		if(session.getAttribute("funAutenticado")!=null){
			request.getRequestDispatcher("WEB-INF/funcionarioSobre.jsp").forward(request, response);	
		}else{
			request.getRequestDispatcher("WEB-INF/gerenteSobre.jsp").forward(request, response);	
		}
	}	
%>