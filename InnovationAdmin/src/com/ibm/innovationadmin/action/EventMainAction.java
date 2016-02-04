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

import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.manager.EventManager;
import com.ibm.innovationadmin.model.ProfileUserModel;
import com.ibm.innovationadmin.model.EventModel;

public class EventMainAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/InnovationDatabase")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	@EJB
	private EventManager evnManager;
	
	private static final Logger log = Logger.getLogger(EventMainAction.class.getName()); 

	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		log.info("TEST DOGET");
		String eveName = request.getParameter("eventName"); 
		List<EventModel> evnList = evnManager.getEventList(eveName, null, null);
		request.setAttribute("evnList", evnList);
		//request.getRequestDispatcher("index.jsp").forward(request, response);
		request.getRequestDispatcher("/view/event.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		
		//String forwardUrl = "/view/event.jsp";
		//request.getRequestDispatcher(forwardUrl).forward(request, response);
		
	}
		
}
