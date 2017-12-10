<%@ page import="br.com.SISLIC.DAO.PenalidadeDAO"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Penalidade"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){//MÉTODO GET
		
		Fornecedor fornecedor = (Fornecedor) request.getSession().getAttribute("forAutenticado");
		PenalidadeDAO buscaPenal = new PenalidadeDAO();
		ArrayList<Penalidade> penalidades = buscaPenal.buscarForn(fornecedor.getId());
		//req.setAttribute("pontuacao", fornecedor.getPontuacao());
		//req.setAttribute("penalidades", penalidades);
		request.getSession().setAttribute("penalidades", penalidades);
		request.getRequestDispatcher("WEB-INF/fornPontuacao.jsp").forward(request, response);
		
	}else{//MÉTODO POST
		
		
	}
		
%>