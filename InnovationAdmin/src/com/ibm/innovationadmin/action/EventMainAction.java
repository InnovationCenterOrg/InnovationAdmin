package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	private static final String eventMainPage = "/view/event.jsp";
	private static final String editPage = "/view/editEvent.jsp";
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("GET Event List");
		String eveName = request.getParameter("keyword"); 
//		int page = 1;
//		if(request.getParameter("page") != null){
//			page = Integer.parseInt(request.getParameter("page"));
//		}
		List<EventModel> evnList = evnManager.getEventList(eveName, null, null);
		request.setAttribute("evnList", evnList);
		request.getRequestDispatcher(eventMainPage).forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("POST Event Main");
		
		String actionType = request.getParameter("actionType");
		int eveId = Integer.parseInt(request.getParameter("eventId"));
		
		// if confirm delete 
		if(actionType.equals("delete")){
			List<ProfileUserModel> userList = evnManager.getRegisterUser(eveId);
			// if this event has registered user
			if(userList.size() > 0){
				request.setAttribute("msg", "This event has registered user!");
			}// if not 
			else{
				evnManager.deleteEvent(eveId);
			}
			doGet(request, response);
			
		}// if click add button
		else if(actionType.equals("redirectAdd")){
			
			request.setAttribute("type", "Add");
			request.getRequestDispatcher(editPage).forward(request, response);
			
		}//if submit form add
		else if(actionType.equals("add")){
			
			String eventName = request.getParameter("eventName");
			String description = request.getParameter("description");
			Date startDate = new Date();
			Date endDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String startDateStr = request.getParameter("startDate"); 
			String endDateStr = request.getParameter("endDate");
			try {
				startDate = evnManager.checkYear(sdf.parse(startDateStr));
				endDate = evnManager.checkYear(sdf.parse(endDateStr));
			} catch (ParseException e) {
			}
			String location = request.getParameter("location");
			String status = request.getParameter("status");
			
			evnManager.createNewEvent(eventName, description, location, startDate, endDate, null, status);
			doGet(request, response);
			
		}// if confirm archive
		else if(actionType.equals("archive")){
		
			
			
		}
	}
}
