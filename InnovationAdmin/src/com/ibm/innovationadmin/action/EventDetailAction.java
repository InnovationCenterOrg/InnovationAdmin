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

public class EventDetailAction extends HttpServlet {
	
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
	
	private static final Logger log = Logger.getLogger(EventDetailAction.class.getName()); 
	private static final String editPage = "/view/editEvent.jsp";
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("GET Event Detail");
		int eveId = Integer.parseInt(request.getParameter("eventId"));
		EventModel event = evnManager.getEventById(eveId);
		List<ProfileUserModel> userList = evnManager.getRegisterUser(eveId);
		request.setAttribute("event", event);
		request.setAttribute("userList", userList);
		request.getRequestDispatcher("/view/eventDetail.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("POST Event Detail");
		
		String actionType = request.getParameter("actionType");
		
		// if click edit button
		if(actionType.equals("redirectEdit")){
			int eventId = Integer.parseInt(request.getParameter("eventId"));
			EventModel event = evnManager.getEventById(eventId);
			request.setAttribute("event", event);
			request.setAttribute("type", "Edit");
			request.getRequestDispatcher(editPage).forward(request, response);
			
		}// if submit edit form
		else if(actionType.equals("edit")){
			int eventId = Integer.parseInt(request.getParameter("eventId"));
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
			
			//if status changed to closed
			if(status.equals("closed")){
				
				//if now > endDate
				if(evnManager.checkCloseRule(eventId)){
					evnManager.updateEvent(eventId, eventName, description, location, startDate, endDate, null, status);
					doGet(request, response);
				}//if now < endDate
				else{
					request.setAttribute("msg", "This event is not allow to closed!");
					EventModel event = evnManager.getEventById(Integer.parseInt(request.getParameter("eventId")));
					request.setAttribute("event", event);
					request.setAttribute("type", "Edit");
					request.getRequestDispatcher(editPage).forward(request, response);
				}
			}// if status is active
			else{
				evnManager.updateEvent(eventId, eventName, description, location, startDate, endDate, null, status);
				doGet(request, response);
			}
		}else if(actionType.equals("genLuckyDraw")){
			
		}
		
		
	}
		
}
