package com.ibm.innovationadmin.action;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutAction extends HttpServlet{

	private static final Logger log = Logger.getLogger(LogoutAction.class.getName()); 

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		request.getSession().removeAttribute("name");
		request.getSession().invalidate();
		
		String forwardUrl = "/login.jsp";
		request.getRequestDispatcher(forwardUrl).forward(request, response);
		
	}
}
