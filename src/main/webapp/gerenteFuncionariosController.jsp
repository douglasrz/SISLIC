<%@ page import="br.com.SISLIC.model.Gerente"%>
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
	FuncionarioDAO funDAO = new FuncionarioDAO();
	PedidoDAO pedidoDAO = new PedidoDAO();
	if(request.getMethod().equals("GET")){
		
		if(request.getParameter("acao")!=null) {
			if(request.getParameter("acao").equals("cadastro")){
				int idFun = Integer.parseInt(request.getParameter("id"));
				if(session.getAttribute("funcionario") == null){
					session.setAttribute("funcionario", funDAO.buscarPorId(idFun));	
					session.setAttribute("pedidosFun", pedidoDAO.buscarPorIdFun(idFun));
				}else{
					if(((Funcionario) session.getAttribute("funcionario")).getCodFunc() != idFun){
						session.setAttribute("funcionario", funDAO.buscarPorId(idFun));	
						session.setAttribute("pedidosFun", pedidoDAO.buscarPorIdFun(idFun));
					}
				}
				request.getRequestDispatcher("WEB-INF/gerenteFuncionarioCadastro.jsp").forward(request, response);				
			}else{
				if(request.getParameter("acao").equals("excluirCadastro")){
					if(funDAO.excluirCadastro(Integer.parseInt(request.getParameter("id")))){
						session.setAttribute("funcionarios", funDAO.buscarTodosExcetoGerente());//Atualizo
						request.getRequestDispatcher("WEB-INF/gerenteFuncionarios.jsp").forward(request, response);
					}else{
						response.getWriter().print("<script>window.alert('Erro interno, tente novamente mais tarde.');</script>");
						}
					
				}else{
					if(request.getParameter("acao").equals("formCadastro")){	
						request.getRequestDispatcher("WEB-INF/gerenteFuncionarioFormCadastro.jsp").forward(request, response);
					}
				}
			}
		}else{
			if(session.getAttribute("funcionarios") == null){
				session.setAttribute("funcionarios", funDAO.buscarTodosExcetoGerente());
				request.getRequestDispatcher("WEB-INF/gerenteFuncionarios.jsp").forward(request, response);	
			}else{
				request.getRequestDispatcher("WEB-INF/gerenteFuncionarios.jsp").forward(request, response);	
			}
		}
	}else{//MÉTODO POST
		
		if(request.getParameter("acao")!=null) {
			if(request.getParameter("acao").equals("alterarCadastro")){					
				Funcionario func = new Funcionario();
				SetorDAO setorDAO = new SetorDAO();
				int idFunc = Integer.parseInt(request.getParameter("id"));
				func.setCodFunc(idFunc);
				func.setNome(request.getParameter("nome"));
				func.setCargo(request.getParameter("cargo"));
				func.setTelefone(request.getParameter("cargo"));
				func.setSenha(request.getParameter("senha"));
				//atualizar o setor 
				String nomeSetor = request.getParameter("setor");
				Setor setor = setorDAO.buscarSomenteOsetorPeloNome(nomeSetor);
				if(setor == null){//PRECISO CADASTRAR
					setorDAO.cadastrar(nomeSetor);
				}
				func.setSetor(setorDAO.buscarSomenteOsetorPeloNome(request.getParameter("setor")));
				if(funDAO.update(func)){
					session.setAttribute("funcionario", funDAO.buscarPorId(idFunc));//ATUALIZO
					request.getRequestDispatcher("WEB-INF/gerenteFuncionarioCadastro.jsp").forward(request, response);
				}else{
					response.getWriter().print("<script>window.alert('Erro interno, tente novamente mais tarde.');</script>");
				}
				}else{
					if(request.getParameter("acao").equals("cadastrar")){
						Funcionario func = new Funcionario();
						func.setLogin(request.getParameter("login"));
						func.setNome(request.getParameter("nome"));
						func.setSenha(request.getParameter("senha"));
						func.setCargo(request.getParameter("cargo"));
						func.setTelefone(request.getParameter("telefone"));
						
						//VERIFICO SE JÁ EXISTE ESSE SETOR, CASO NEGATIVO PRECISO CADASTRAR ELE
						SetorDAO setorDAO = new SetorDAO();
						String nomeSetor = request.getParameter("setor");
						Setor setor = setorDAO.buscarSomenteOsetorPeloNome(nomeSetor);
						if(setor == null){//PRECISO CADASTRAR
							setorDAO.cadastrar(nomeSetor);
						}
						func.setSetor(setorDAO.buscarSomenteOsetorPeloNome(request.getParameter("setor")));
						if(funDAO.cadastrar(func)){
							session.setAttribute("funcionarios", funDAO.buscarTodosExcetoGerente());//ATUALIZO
							request.getRequestDispatcher("WEB-INF/gerenteFuncionarios.jsp").forward(request, response);
						}else{
							response.getWriter().print("<script>window.alert('Não foi possível realizar o cadastro, tente com outro login.'); href=\"gerenteFuncionariosController.jsp?acao=formCadastro\"</script>");
						}
					}
				}					
			}
		}	
			
			
%>