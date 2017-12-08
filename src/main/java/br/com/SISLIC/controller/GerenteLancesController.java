package br.com.SISLIC.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.FornecedorDAO;
import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Fornecedor;

@WebServlet("/gerentelancescontroller.do")
public class GerenteLancesController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
			
			if(acao.equals("lances")) {
				LanceDAO lanceDAO = new LanceDAO();
				lanceDAO.todosLances();
				if(req.getSession().getAttribute("todosLances") == null) {
					req.getSession().setAttribute("todosLances", lanceDAO.todosLances());
				}
				req.getRequestDispatcher("WEB-INF/gerenteLances.jsp").forward(req, resp);
			}else {
				if(acao.equals("lancesdopedido")) {
					
					int id = Integer.parseInt(req.getParameter("id"));
					LanceDAO lanceDAO = new LanceDAO();
					req.getSession().setAttribute("lances", lanceDAO.buscarPorIdPedido(id));
					req.getRequestDispatcher("WEB-INF/gerenteLancesPedido.jsp").forward(req, resp);
				}else {
					if(acao.equals("lance")) {
						int id = Integer.parseInt(req.getParameter("id"));
						LanceDAO lanceDAO = new LanceDAO();
						Lance lance = lanceDAO.buscarPorId(id);
						req.setAttribute("lance", lance);
						req.getRequestDispatcher("WEB-INF/gerenteLance.jsp").forward(req, resp);
					}
				}
			}
		}
	}
}
