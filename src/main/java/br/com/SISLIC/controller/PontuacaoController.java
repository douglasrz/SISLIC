package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.PenalidadeDAO;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Penalidade;

@WebServlet("/pontcontroller.do")
public class PontuacaoController extends HttpServlet{
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		Fornecedor fornecedor = (Fornecedor) req.getSession().getAttribute("forAutenticado");
		PenalidadeDAO buscaPenal = new PenalidadeDAO();
		ArrayList<Penalidade> penalidades = buscaPenal.buscarForn(fornecedor.getId());
		//req.setAttribute("pontuacao", fornecedor.getPontuacao());
		//req.setAttribute("penalidades", penalidades);
		req.getSession().setAttribute("penalidades", penalidades);
		req.getRequestDispatcher("WEB-INF/fornPontuacao.jsp").forward(req, resp);
	}
	
}
