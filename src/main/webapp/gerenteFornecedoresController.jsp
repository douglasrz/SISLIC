<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.DAO.FornecedorDAO"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	FornecedorDAO fornDAO = new FornecedorDAO(); 
	if(request.getMethod().equals("GET")){
		
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
			if(acao.equals("fornPendentes")) {
				if(request.getParameter("id")!=null) {
					int id = Integer.parseInt(request.getParameter("id"));
					if(request.getSession().getAttribute("fornecedor") == null) {
						request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
					}else {
						if(((Fornecedor) request.getSession().getAttribute("fornecedor")).getId() != id){
							request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
						}
					}
					request.getRequestDispatcher("WEB-INF/gerenteFornecedorCadastro.jsp").forward(request, response);		
					
				}else {
					if(request.getSession().getAttribute("fornecedores") == null) {						
						request.getSession().setAttribute("fornecedores", fornDAO.buscarTodosPendentes());
						request.getSession().setAttribute("tipoFornPendete", true);
					}else {
						if(!((boolean) request.getSession().getAttribute("tipoFornPendete"))) {
							request.getSession().setAttribute("fornecedores", fornDAO.buscarTodosPendentes());
							request.getSession().setAttribute("tipoFornPendete", true);
						}
					}
					request.getRequestDispatcher("WEB-INF/gerenteFornecedores.jsp").forward(request, response);
				}
			}else {
				if(acao.equals("fornCadastrados")) {
					if(request.getParameter("id")!=null) {
						int id = Integer.parseInt(request.getParameter("id"));						
						if(request.getSession().getAttribute("fornecedor") == null) {							
							request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
						}else {
							if(((Fornecedor) request.getSession().getAttribute("fornecedor")).getId() != id){
								request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
							}
						}
						request.getRequestDispatcher("WEB-INF/gerenteFornecedorCadastro.jsp").forward(request, response);					
					}else {
						if(request.getSession().getAttribute("fornecedores") == null) {
							request.getSession().setAttribute("fornecedores", fornDAO.buscarTodosAutorizados());
							request.getSession().setAttribute("tipoFornPendete", false);
						}else {
							if(((boolean) request.getSession().getAttribute("tipoFornPendete"))) {
								request.getSession().setAttribute("fornecedores", fornDAO.buscarTodosAutorizados());
								request.getSession().setAttribute("tipoFornPendete", false);
							}
						}
						request.getRequestDispatcher("WEB-INF/gerenteFornecedores.jsp").forward(request, response);
					}
				}
			}
		}
	}else{
		
		
	}	
			
			
			%>