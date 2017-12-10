<%@ page import="br.com.SISLIC.DAO.FornecedorDAO"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){
		
		request.getRequestDispatcher("WEB-INF/fornCadastro.jsp").forward(request,response);
	
	}else{
			//MÉTODO POST	
		String acao = request.getParameter("acao");
		
		if(acao.equals("cadastrar")) {
			String login = request.getParameter("login");
			String rSocial = request.getParameter("razaoSocial");
			String senha = request.getParameter("novasenha");
			String cnpj = request.getParameter("cnpj");
			String telefone = request.getParameter("telefone");
			String email = request.getParameter("email");
			
			Fornecedor forn = new Fornecedor(login, senha, cnpj, rSocial, telefone, email);
			FornecedorDAO forDAO = new FornecedorDAO();
			if(forDAO.cadastrar(forn)) {
				response.getWriter().print("<script> window.alert('Solicitação realizada com sucesso, seu cadastro será analisado. Após a análise você será notificado por e-mail, para poder usar o sistema. '); location.href='login.html';</script>");
			}else {
				response.getWriter().print("<script> window.alert('Erro ao efetuar a solicitação de cadastro, talvez esse login já existe, tente outro'); location.href='registroForn.html';</script>");
			}
		}else {
			if(acao.equals("alterar")) {
				String login = ((Fornecedor) request.getSession().getAttribute("forAutenticado")).getLogin();
				String rSocial = request.getParameter("razaoSocial");
				String senha = request.getParameter("novasenha");
				String telefone = request.getParameter("telefone");
				String email = request.getParameter("email");
				
				Fornecedor forn =new Fornecedor(login,senha,rSocial,telefone,email);
				FornecedorDAO forDAO = new FornecedorDAO();
				//req.setAttribute("forAutenticado", forn);
				if(forDAO.updateCad(forn)) {					
					Fornecedor atualizado = forDAO.autenticar(forn.getLogin(),forn.getSenha());
					HttpSession sessao = request.getSession();
					sessao.removeAttribute("forAutenticado");					
					sessao.setAttribute("forAutenticado",atualizado);
					
					response.getWriter().print("<script> window.alert('Informações alteradas com sucesso!'); location.href='fornecedorCadastroController.jsp';</script>");
				}else {
					response.getWriter().print("<script> window.alert('Erro ao alterar, tente novamente.'); location.href='fornecedorCadastroController.jsp';</script>");
				}
			}
		}
	}


%>