<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.DAO.GerenteDAO"%>
<%@ page import="br.com.SISLIC.DAO.PedidoDAO"%>
<%@ page import="br.com.SISLIC.DAO.SetorDAO"%>
<%@ page import="br.com.SISLIC.model.Setor"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	GerenteDAO gerDAO = new GerenteDAO();
	PedidoDAO pedidoDAO = new PedidoDAO();
	Gerente gerente = ((Gerente) request.getSession().getAttribute("gerAutenticado"));  
	
	if(request.getMethod().equals("GET")){
		session.setAttribute("pedidosGer", pedidoDAO.buscarPorIdFun(gerente.getCodFunc()));
		request.getRequestDispatcher("WEB-INF/gerenteCadastro.jsp").forward(request, response);	
	}else{//MÉTODO POST		
		if(request.getParameter("acao") != null){
			if(request.getParameter("acao").equals("alterarCadastro")) {
				SetorDAO setorDAO = new SetorDAO();
				gerente.setNome(request.getParameter("nome"));
				gerente.setCargo(request.getParameter("cargo"));
				gerente.setTelefone(request.getParameter("cargo"));
				gerente.setSenha(request.getParameter("novasenha"));
				//atualizar o setor 
				String nomeSetor = request.getParameter("setor");
				Setor setor = setorDAO.buscarSomenteOsetorPeloNome(nomeSetor);
				if(setor == null){//PRECISO CADASTRAR
					setorDAO.cadastrar(nomeSetor);
				}
				gerente.setSetor(setorDAO.buscarSomenteOsetorPeloNome(request.getParameter("setor")));
				if(gerDAO.update(gerente)){
					session.setAttribute("gerAutenticado", gerente);//ATUALIZO
					request.getRequestDispatcher("WEB-INF/gerenteCadastro.jsp").forward(request, response);
				}else{
					response.getWriter().print("<script>window.alert('Erro interno, tente novamente mais tarde.');</script>");
				}
			}
		}
	}	
			
%>