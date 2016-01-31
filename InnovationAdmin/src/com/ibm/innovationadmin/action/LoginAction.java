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
import javax.sql.DataSource;

import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class LoginAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	//@Resource(lookup = "jdbc/SQL Database-4o")
	//DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	private static final Logger log = Logger.getLogger(LoginAction.class.getName()); 

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		log.info("TEST DOGET");
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
	//	ProfileUserModel profile = profileUserManager.getProfileUserById(1);
//		String forwardUrl = "/home.jsp?test="+profile.getProFullName();
		String forwardUrl = "/view/event.jsp";
		request.getRequestDispatcher(forwardUrl).forward(request, response);
	}
		
}
