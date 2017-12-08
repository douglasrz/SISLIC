package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.SISLIC.DAO.CategoriaDAO;
import br.com.SISLIC.model.Categoria;
import br.com.SISLIC.model.Fornecedor;
@WebServlet("/categoriacontroller.do")
public class CategoriaController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String acao = req.getParameter("acao");
		int idCategoria = Integer.parseInt(req.getParameter("id"));
		int idFornecedor = ((Fornecedor) req.getSession().getAttribute("forAutenticado")).getId();
	
		if(acao.equals("excluir")) {
				CategoriaDAO catDAO = new CategoriaDAO();
				if(catDAO.excluir(idCategoria)) {
					//Atualizando as categorias
					ArrayList<Categoria> categorias = catDAO.buscarPorForn(idFornecedor);
					HttpSession sessao = req.getSession(); 
					((Fornecedor) sessao.getAttribute("forAutenticado")).setCategorias(categorias);	
					resp.getWriter().print("<script> window.alert('Excluído com sucesso!'); location.href='cadastrocontroller.do';</script>");
				}else {
					resp.getWriter().print("<script> window.alert('Erro ao excluir, tente novamente.'); location.href='cadastrocontroller.do';</script>");
				}
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String nome = req.getParameter("nome");
		String descricao = req.getParameter("descricao");
		Categoria categoria = new Categoria();		
		categoria.setNome(nome);
		categoria.setDescricao(descricao);
		CategoriaDAO cateDAO = new CategoriaDAO();
		//QUANDO FOR O GERENTE
		if(((Fornecedor) req.getSession().getAttribute("forAutenticado")) == null){
			if(cateDAO.cadastrarCat(categoria)) {	
				((ArrayList<Categoria>) req.getSession().getAttribute("categorias")).clear();
				resp.getWriter().print("<script> window.alert('Cadastrado com sucesso!'); location.href='cadastropedido.do';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente e/ou verifique se já existe uma igual.'); location.href='cadastropedido.do';</script>");
			}
		}else {
			//QUANDO FOR O FORNECEDOR
			int idFornecedor = ((Fornecedor) req.getSession().getAttribute("forAutenticado")).getId();
			categoria.setIdFornecedor(idFornecedor);
			
			if(cateDAO.cadastrarParaForn(categoria)) {
				((Fornecedor) req.getSession().getAttribute("forAutenticado")).getCategorias().clear();	
				//Atualizando as categorias
				ArrayList<Categoria> categorias = cateDAO.buscarPorForn(idFornecedor);
				HttpSession sessao = req.getSession(); 
				((Fornecedor) sessao.getAttribute("forAutenticado")).setCategorias(categorias);
				resp.getWriter().print("<script> window.alert('Cadastrado com sucesso!'); location.href='cadastrocontroller.do';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao cadastrar, tente novamente'); location.href='cadastrocontroller.do';</script>");
			}
		}
	}
}
