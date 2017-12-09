<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.DAO.FornecedorDAO"%>
<%@ page import="br.com.SISLIC.DAO.FuncionarioDAO"%>
<%@ page import="br.com.SISLIC.DAO.GerenteDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	//MÉTODO POST
	if(request.getMethod().equals("POST")){
		//cria a sessao
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
			
		if(request.getParameter("perfil").equals("Fornecedor")) {
			FornecedorDAO forDAO = new FornecedorDAO();
			Fornecedor forAutenticado = forDAO.autenticar(login,senha);
			if(forAutenticado!=null) {
				if(forAutenticado.isAutorizado()) {
					HttpSession sessao = request.getSession(); //criando a sessao
					sessao.setAttribute("forAutenticado", forAutenticado);//add o usuario a sessao			
					sessao.setMaxInactiveInterval(60*10);
					//sessao.setAttribute("nomeForn",forAutenticado.getLogin());
					//Direcionando para a página principal
					request.getRequestDispatcher("pedidocontroller.do").forward(request, response);
				}else {
					response.getWriter().print("<script> window.alert('Seu cadastrado ainda não foi autorizado, aguarde a análise.'); location.href='login.html';</script>");
					}
			}else {
				response.getWriter().print("<script> window.alert('Usuario não encontrado'); location.href='login.html';</script>");
			}
		}else {
			if(request.getParameter("perfil").equals("Gerente")) {
				GerenteDAO gerDAO = new GerenteDAO();
				Gerente gerAutenticado = gerDAO.autenticar(login,senha);
				if(gerAutenticado!=null) {
					HttpSession sessao = request.getSession();
					sessao.setAttribute("gerAutenticado", gerAutenticado);
					sessao.setMaxInactiveInterval(60*10);					
					request.getRequestDispatcher("gerentePedidosController.jsp").forward(request, response);
				}else {
					response.getWriter().print("<script> window.alert('Usuário não encontrado'); location.href='login.html';</script>");
				}
			}else {
				FuncionarioDAO funDAO = new FuncionarioDAO();
				Funcionario funAutenticado = funDAO.autenticar(login,senha);						
				if(funAutenticado!=null) {
					HttpSession sessao = request.getSession(); //criando a sessao
					sessao.setAttribute("funAutenticado", funAutenticado);//add o usuario a sessao			
					sessao.setMaxInactiveInterval(60*10);
					request.getRequestDispatcher("funcionarioController.jsp").forward(request, response);
				}else {
					response.getWriter().print("<script> window.alert('Usuário não encontrado'); location.href='login.html';</script>");
					}
			}
			
		}
	
	}else{
		//Destroi a sessao
		HttpSession sessao = request.getSession(false);
		//Quando não tem a sessao (FALSE), não faz nada
		if(sessao!=null) {
			sessao.invalidate();
		}
		response.sendRedirect("login.html");
	}
%>