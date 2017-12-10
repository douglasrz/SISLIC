<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="br.com.SISLIC.DAO.FuncionarioDAO"%>
<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.DAO.SetorDAO"%>
<%@ page import="br.com.SISLIC.model.Setor"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	FuncionarioDAO gerDAO = new FuncionarioDAO();
	PedidoDAO pedidoDAO = new PedidoDAO();
	Funcionario funcionario = ((Funcionario) request.getSession().getAttribute("funAutenticado"));  
	
	if(request.getMethod().equals("GET")){
		
		if(session.getAttribute("pedidosFun") == null){
			session.setAttribute("pedidosFun", pedidoDAO.buscarPorIdFun(funcionario.getCodFunc()));
		}
		request.getRequestDispatcher("WEB-INF/funcionarioCadastro.jsp").forward(request, response);	
		
	}else{//MÉTODO POST		
		if(request.getParameter("acao") != null){
			if(request.getParameter("acao").equals("alterarCadastro")) {
				
				SetorDAO setorDAO = new SetorDAO();
				
				funcionario.setNome(request.getParameter("nome"));
				funcionario.setCargo(request.getParameter("cargo"));
				funcionario.setTelefone(request.getParameter("cargo"));
				funcionario.setSenha(request.getParameter("novasenha"));
				//atualizar o setor 
				String nomeSetor = request.getParameter("setor");
				Setor setor = setorDAO.buscarSomenteOsetorPeloNome(nomeSetor);
				if(setor == null){//PRECISO CADASTRAR
					setorDAO.cadastrar(nomeSetor);
				}
				funcionario.setSetor(setorDAO.buscarSomenteOsetorPeloNome(request.getParameter("setor")));
				if(gerDAO.update(funcionario)){
					session.setAttribute("funAutenticado", funcionario);//ATUALIZO
					request.getRequestDispatcher("WEB-INF/funcionarioCadastro.jsp").forward(request, response);
				}else{
					response.getWriter().print("<script>window.alert('Erro interno, tente novamente mais tarde.');</script>");
				}
			}
		}
	}	
			
%>