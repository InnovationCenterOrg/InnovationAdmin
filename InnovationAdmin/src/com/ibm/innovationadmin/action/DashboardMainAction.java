package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
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

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.EventManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.EventModel;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class DashboardMainAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;
	
	@EJB
	private EventManager evnManager;
	
	private static final Logger log = Logger.getLogger(DashboardMainAction.class.getName()); 

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		log.info("TEST DOGET");
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		if(request.getSession().getAttribute("name") == null){
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else{
			List<EventModel> evnList = evnManager.getEventList(null, null, CommonConstants.EVENT_STATUS_ACTIVE);
			request.setAttribute("evnList", evnList);
		
			String forwardUrl = "/view/dashboard.jsp";

			request.getRequestDispatcher(forwardUrl).forward(request, response);
		
		}
	}
		
}
