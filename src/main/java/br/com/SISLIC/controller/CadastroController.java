package br.com.SISLIC.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.SISLIC.DAO.FornecedorDAO;
import br.com.SISLIC.model.Fornecedor;

@WebServlet("/cadastrocontroller.do")
public class CadastroController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("WEB-INF/fornCadastro.jsp").forward(req,resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String acao = req.getParameter("acao");
		
		if(acao.equals("cadastrar")) {
			String login = req.getParameter("login");
			String rSocial = req.getParameter("razaoSocial");
			String senha = req.getParameter("novasenha");
			String cnpj = req.getParameter("cnpj");
			String telefone = req.getParameter("telefone");
			String email = req.getParameter("email");
			
			Fornecedor forn = new Fornecedor(login, senha, cnpj, rSocial, telefone, email);
			FornecedorDAO forDAO = new FornecedorDAO();
			if(forDAO.cadastrar(forn)) {
				resp.getWriter().print("<script> window.alert('Solicita��o realizada com sucesso, seu cadastro ser� analisado. Ap�s a an�lise voc� ser� notificado por e-mail, para poder usar o sistema. '); location.href='login.html';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao efetuar a solicita��o de cadastro, talvez esse login j� existe, tente outro'); location.href='registroForn.html';</script>");
			}
		}else {
			if(acao.equals("alterar")) {
				String login = ((Fornecedor) req.getSession().getAttribute("forAutenticado")).getLogin();
				String rSocial = req.getParameter("razaoSocial");
				String senha = req.getParameter("novasenha");
				String telefone = req.getParameter("telefone");
				String email = req.getParameter("email");
				
				Fornecedor forn =new Fornecedor(login,senha,rSocial,telefone,email);
				FornecedorDAO forDAO = new FornecedorDAO();
				//req.setAttribute("forAutenticado", forn);
				if(forDAO.updateCad(forn)) {
					
					Fornecedor atualizado = forDAO.autenticar(forn);
					HttpSession sessao = req.getSession();
					sessao.removeAttribute("forAutenticado");					
					sessao.setAttribute("forAutenticado",atualizado);
					
					resp.getWriter().print("<script> window.alert('Informa��es alteradas com sucesso!'); location.href='cadastrocontroller.do';</script>");
				}else {
					resp.getWriter().print("<script> window.alert('Erro ao alterar, tente novamente.'); location.href='cadastrocontroller.do';</script>");
				}
			}
		}
	}
}
