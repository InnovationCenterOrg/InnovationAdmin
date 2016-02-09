package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
import com.ibm.innovationadmin.constants.CommonConstants;

public class UserMainAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;
	
	@Resource(lookup = "jdbc/InnovationDatabase")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;

	private static final Logger log = Logger.getLogger(UserMainAction.class.getName()); 
	private static final String forwardUrl = "/view/user.jsp";
	private static final String editUser = "/view/editUser.jsp";
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
//		doPost(request,response);
		log.info("TEST DOGET");
		String keyword = request.getParameter("keyword"); 
//		int page = 1;
//		if(request.getParameter("page") != null){
//			page = Integer.parseInt(request.getParameter("page"));
//		}
		List<ProfileUserModel> usrList = profileUserManager.getProfileUserList(keyword);
		request.setAttribute("userList", usrList);
		request.getRequestDispatcher(forwardUrl).forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		String actionType = request.getParameter("actionType");
		
		if(actionType.equals("resetpwd")){
			
			int proId = Integer.parseInt(request.getParameter("proId"));
			log.info("Reset PWD");
			profileUserManager.changePassword(proId, CommonConstants.DEFAULT_PASSWORD);
			request.setAttribute("msg", CommonConstants.DEFAULT_PASSWORD);
			doGet(request,response);
			
		}else if(actionType.equals("redirectAdd")){
			
			request.setAttribute("type", "Add");
			request.getRequestDispatcher(editUser).forward(request, response);
			
		}else if(actionType.equals("check")){
			
			String username = request.getParameter("username");
			boolean isDup = profileUserManager.isDuplicateUsername(username);
			PrintWriter out = response.getWriter();
			out.write("isDup = "+isDup);
			
		}else if(actionType.equals("add")){
			
			
			
		}
		
		
	}
		
}
