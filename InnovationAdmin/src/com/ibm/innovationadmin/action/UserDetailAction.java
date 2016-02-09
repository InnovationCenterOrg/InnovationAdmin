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

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class UserDetailAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;
	
	
	@Resource(lookup = "jdbc/InnovationDatabase")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	private static final Logger log = Logger.getLogger(UserDetailAction.class.getName()); 
	private static final String editUser = "/view/editUser.jsp";
	private static final String forwardUrl = "/view/userDetail.jsp";
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOGET");
		int proId = Integer.parseInt(request.getParameter("proid"));
		ProfileUserModel user = profileUserManager.getProfileUserById(proId);
		request.setAttribute("user", user);
		request.getRequestDispatcher(forwardUrl).forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		String actionType = request.getParameter("actionType");
		int proId = Integer.parseInt(request.getParameter("proId"));
		if(actionType.equals("resetpwd")){
			
			log.info("Reset PWD");
			profileUserManager.changePassword(proId, CommonConstants.DEFAULT_PASSWORD);
			request.setAttribute("msg", CommonConstants.DEFAULT_PASSWORD);
			doGet(request,response);
			
		}else if(actionType.equals("redirectEdit")){
			
			request.setAttribute("type", "Edit");
			request.getRequestDispatcher(editUser).forward(request, response);
			
		}

		
		
	}
		
}