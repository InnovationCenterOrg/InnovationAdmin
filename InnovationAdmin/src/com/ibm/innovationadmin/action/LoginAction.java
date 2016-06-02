package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class LoginAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	private static final Logger log = Logger.getLogger(LoginAction.class.getName()); 

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOGET");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("Login");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(!username.equals("") && !password.equals("")){
			ProfileUserModel profile = profileUserManager.authen(username, password);
			if(profile != null){
				String fullName = profile.getProFullName();
				request.getSession().setAttribute("name", fullName);
				response.sendRedirect("EventMainAction");
			}else{
				request.setAttribute("error", "Username or password is incorrect!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			
		}else{
			request.setAttribute("error", "Please fill username and password!");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		
	}
}
