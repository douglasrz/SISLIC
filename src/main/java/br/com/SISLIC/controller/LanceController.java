package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;

@WebServlet("/lancescontroller.do")
public class LanceController extends HttpServlet{
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		
		String acao = new String();
		if(req.getParameter("acao")!=null) {
			acao = req.getParameter("acao");
			
		}else {
			req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
		}
		
		if(acao.equals("lance")) {
			
			int idPedido = Integer.parseInt(req.getParameter("id"));
			Lance lance = new Lance();
			lance.setIdPedido(idPedido);
			float total = Float.parseFloat(req.getParameter("total"));
			lance.setTotal(total);
			Date data = new Date();
			lance.setData(data);
			Fornecedor forn = (Fornecedor) req.getSession().getAttribute("forAutenticado");
			lance.setIdfornecedor(forn.getId());
			LanceDAO lanceDAO = new LanceDAO();
			
			if(lanceDAO.cadastrar(lance)) {					
				resp.getWriter().print("<script> window.alert('Lance efetuado com sucesso! Aguarde o contato por e-mail'); location.href='cadastrocontroller.do';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao efetuar o lance!'); location.href='cadastrocontroller.do';</script>");
			}
		}	
	}
}
