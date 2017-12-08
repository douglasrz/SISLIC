package br.com.SISLIC.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.FornecedorDAO;
import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.model.Fornecedor;

@WebServlet("/fornsgerentecontroller.do")
public class GerenteFornecedoresController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
			
			if(acao.equals("fornPendentes")) {
				FornecedorDAO fornDAO = new FornecedorDAO();
				if(req.getParameter("id")!=null) {
					int id = Integer.parseInt(req.getParameter("id"));
					if(req.getSession().getAttribute("fornecedor") == null) {
						req.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
					}else {
						if(((Fornecedor) req.getSession().getAttribute("fornecedor")).getId() != id){
							req.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(id));
						}
					}
					req.getRequestDispatcher("WEB-INF/gerenteFornecedorCadastro.jsp").forward(req, resp);					
				}else {
					if(req.getSession().getAttribute("fornecedores") == null) {
						req.getSession().setAttribute("fornecedores", fornDAO.buscarTodosPendentes());
						req.getSession().setAttribute("tipoFornPendete", true);
					}else {
						if(!((boolean) req.getSession().getAttribute("tipoFornPendete"))) {
							req.getSession().setAttribute("fornecedores", fornDAO.buscarTodosPendentes());
							req.getSession().setAttribute("tipoFornPendete", true);
						}
					}
					req.getRequestDispatcher("WEB-INF/gerenteFornecedores.jsp").forward(req, resp);
				}
			}else {
				if(acao.equals("fornCadastrados")) {
					FornecedorDAO fornDAO = new FornecedorDAO();
					LanceDAO lanceDAO = new LanceDAO();
					if(req.getParameter("id")!=null) {
						int id = Integer.parseInt(req.getParameter("id"));
						
						if(req.getSession().getAttribute("fornecedor") == null) {
							Fornecedor forn = fornDAO.buscarPorId(id);						
							req.getSession().setAttribute("fornecedor", forn);
						}else {
							if(((Fornecedor) req.getSession().getAttribute("fornecedor")).getId() != id){
								Fornecedor forn = fornDAO.buscarPorId(id);
								forn.setLances(lanceDAO.lancesFornId(forn.getId()));						
								req.getSession().setAttribute("fornecedor", forn);
							}
						}
						req.getRequestDispatcher("WEB-INF/gerenteFornecedorCadastro.jsp").forward(req, resp);					
					}else {
						if(req.getSession().getAttribute("fornecedores") == null) {
							req.getSession().setAttribute("fornecedores", fornDAO.buscarTodosAutorizados());
							req.getSession().setAttribute("tipoFornPendete", false);
						}else {
							if(((boolean) req.getSession().getAttribute("tipoFornPendete"))) {
								req.getSession().setAttribute("fornecedores", fornDAO.buscarTodosAutorizados());
								req.getSession().setAttribute("tipoFornPendete", false);
							}
						}
						req.getRequestDispatcher("WEB-INF/gerenteFornecedores.jsp").forward(req, resp);
					}
				}
			}
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
