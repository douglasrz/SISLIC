<%@ page import="br.com.SISLIC.DAO.CategoriaDAO"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){
		
		String acao = request.getParameter("acao");
		int idCategoria = Integer.parseInt(request.getParameter("id"));
		int idFornecedor = ((Fornecedor) request.getSession().getAttribute("forAutenticado")).getId();
	
		if(acao.equals("excluir")) {
				CategoriaDAO catDAO = new CategoriaDAO();
				if(catDAO.excluir(idCategoria)) {
					//Atualizando as categorias
					ArrayList<Categoria> categorias = catDAO.buscarPorForn(idFornecedor);
					HttpSession sessao = request.getSession(); 
					((Fornecedor) sessao.getAttribute("forAutenticado")).setCategorias(categorias);	
					response.getWriter().print("<script> window.alert('Excluído com sucesso!'); location.href='fornecedorCadastroController.jsp';</script>");
				}else {
					response.getWriter().print("<script> window.alert('Erro ao excluir, tente novamente.'); location.href='fornecedorCadastroController.jsp';</script>");
				}
		}
	}else{
		//MÉTODO POST
		String nome = request.getParameter("nome");
		String descricao = request.getParameter("descricao");
		Categoria categoria = new Categoria();		
		categoria.setNome(nome);
		categoria.setDescricao(descricao);
		CategoriaDAO cateDAO = new CategoriaDAO();
		//QUANDO FOR O GERENTE
		if(((Gerente) request.getSession().getAttribute("gerAutenticado")) != null){
			if(cateDAO.cadastrarCat(categoria)) {	
				request.getSession().setAttribute("categorias", cateDAO.buscarTodas());
				response.getWriter().print("<script> window.alert('Cadastrado com sucesso!'); location.href='cadastroPedidoController.jsp';</script>");
			}else {
				response.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente e/ou verifique se já existe uma igual.'); location.href='gerenteCadastroController.jsp';</script>");
			}
		}else {
			if(((Funcionario) session.getAttribute("funAutenticado")) != null){
				if(cateDAO.cadastrarCat(categoria)) {	
					request.getSession().setAttribute("categorias", cateDAO.buscarTodas());
					response.getWriter().print("<script> window.alert('Cadastrado com sucesso!'); location.href='funcionarioCadastroPedidoController.jsp';</script>");
				}else {
					response.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente e/ou verifique se já existe uma igual.'); location.href='funcionarioCadastroController.jsp';</script>");
				}
				
			}else{
			
			//QUANDO FOR O FORNECEDOR
			int idFornecedor = ((Fornecedor) request.getSession().getAttribute("forAutenticado")).getId();
			categoria.setIdFornecedor(idFornecedor);
			
			if(cateDAO.cadastrarParaForn(categoria)) {
				((Fornecedor) request.getSession().getAttribute("forAutenticado")).getCategorias().clear();	
				//Atualizando as categorias
				ArrayList<Categoria> categorias = cateDAO.buscarPorForn(idFornecedor);
				HttpSession sessao = request.getSession(); 
				((Fornecedor) sessao.getAttribute("forAutenticado")).setCategorias(categorias);
				response.getWriter().print("<script> window.alert('Cadastrado com sucesso!'); location.href='fornecedorCadastroController.jsp';</script>");
			}else {
				response.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente'); location.href='fornecedorCadastroController.jsp';</script>");
			}
		}
	}
}

%>