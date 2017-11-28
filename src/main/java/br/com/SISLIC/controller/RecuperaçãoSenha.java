package br.com.SISLIC.controller;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;

import br.com.SISLIC.DAO.RecuperacaoSenhaDAO;
import br.com.SISLIC.model.Email;

@WebServlet("/recuperarsenha.do")
public class RecuperaçãoSenha extends HttpServlet{
		

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String login = req.getParameter("username");
		String email = req.getParameter("email");
		
		RecuperacaoSenhaDAO ver = new RecuperacaoSenhaDAO();
		if(ver.verifEmailLoginForn(login, email)) {
			Email enviarEmail = new Email();
			try {
				enviarEmail.Enviar(login, email);
			} catch (EmailException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			resp.getWriter().print("<script> window.alert('Uma nova senha foi enviado para seu e-mail!'); location.href='login.html';</script>");
		}else {
			//System.out.println("passou");
			resp.getWriter().print("<script> window.alert('O login e e-mail inseridos não corresponde a um cadastrado!'); location.href='login.html';</script>");
		}
	}
	
}

