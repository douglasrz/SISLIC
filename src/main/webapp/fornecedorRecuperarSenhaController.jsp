<%@ page import="br.com.SISLIC.DAO.RecuperacaoSenhaDAO"%>
<%@ page import="org.apache.commons.mail.EmailException"%>
<%@ page import="br.com.SISLIC.model.Email"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){//MÉTODO GET
	
		
	}else{//MÉTODO POST
		
		String login = request.getParameter("username");
		String email = request.getParameter("email");
		
		RecuperacaoSenhaDAO ver = new RecuperacaoSenhaDAO();
		if(ver.verifEmailLoginForn(login, email)) {
			Email enviarEmail = new Email();
			try {
				enviarEmail.emailRecuperacaoSenha(login, email);
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			response.getWriter().print("<script> window.alert('Uma nova senha foi enviado para seu e-mail!'); location.href='login.html';</script>");
		}else {
			response.getWriter().print("<script> window.alert('O login e e-mail inseridos não corresponde a um cadastrado!'); location.href='login.html';</script>");
		}
	}
%>