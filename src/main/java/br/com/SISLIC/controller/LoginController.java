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

@WebServlet("/logincontroller.do")
public class LoginController extends HttpServlet{
	/*
	 * Esta classe � responsavel pela autentica��o do usuario, criando a sessao para o mesmo pelo m�todo Post e redirecionan para o index,
	 *  e quando chamo pelo m�todo get ele sair da sess�o redirecianando para a p�gina de login
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//cria a sessao
		String login = req.getParameter("login");
		String senha = req.getParameter("senha");
		
		if(req.getParameter("perfil").equals("Fornecedor")) {
			Fornecedor forn =new Fornecedor();
			forn.setLogin(login);
			forn.setSenha(senha);
			FornecedorDAO forDAO = new FornecedorDAO();
			Fornecedor forAutenticado = forDAO.autenticar(forn);
			if(forAutenticado!=null) {
				HttpSession sessao = req.getSession(); //criando a sessao
				sessao.setAttribute("forAutenticado", forAutenticado);//add o usuario a sessao			
				sessao.setMaxInactiveInterval(60*10);
				//sessao.setAttribute("nomeForn",forAutenticado.getLogin());
				//Direcionando para a p�gina principal
				req.getRequestDispatcher("pedidocontroller.do").forward(req, resp);;
			}else {
				resp.getWriter().print("<script> window.alert('Usuario n�o encontrado'); location.href='login.html';</script>");
			}
		}else {
			if(req.getParameter("perfil").equals("Gerente")) {
				resp.getWriter().print("<script> window.alert('Ainda n�o implementei a parte do gerente'); location.href='login.html';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Ainda n�o implementei a parte do funcionario'); location.href='login.html';</script>");
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Destroi a sessao
		HttpSession sessao = req.getSession(false);
		//Quando n�o tem a sessao (FALSE), n�o faz nada
		if(sessao!=null) {
			sessao.invalidate();
		}
		resp.sendRedirect("login.html");
	}
}
