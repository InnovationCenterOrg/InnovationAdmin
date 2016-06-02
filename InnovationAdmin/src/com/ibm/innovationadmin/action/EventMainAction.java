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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.google.gson.Gson;
import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.LuckyDrawManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.manager.EventManager;
import com.ibm.innovationadmin.manager.RegisterEventManager;
import com.ibm.innovationadmin.model.LuckyDrawModel;
import com.ibm.innovationadmin.model.ProfileUserModel;
import com.ibm.innovationadmin.model.EventModel;
import com.ibm.innovationadmin.model.RegisterEventModel;

public class EventMainAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	@EJB
	private EventManager evnManager;
	
	@EJB
	private RegisterEventManager registerEventManager;
	
	@EJB
	private LuckyDrawManager luckyDrawManager;
	
	private static final Logger log = Logger.getLogger(EventMainAction.class.getName()); 
	private static final String eventMainPage = "/view/event.jsp";
	private static final String editPage = "/view/editEvent.jsp";
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("GET Event List");
		
		if(request.getSession().getAttribute("name") == null){
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else{
			String eveName = request.getParameter("keyword"); 
			int page = 1;
			if(request.getParameter("page") != null){
				page = Integer.parseInt(request.getParameter("page"));
			}
			List<EventModel> evnList = evnManager.getEventList(eveName, null, null, true);
			
			int size = CommonConstants.PAGING;
			int from = Math.max(0,(page-1)*size);
			int to = Math.min(evnList.size(),page*size);
			
			List<EventModel> eventPaging = evnList.subList(from, to);
			
			int endPage = (int) Math.ceil((double) evnList.size() / size);
					
			request.setAttribute("evnList", eventPaging);
			request.setAttribute("startPage", 1);
			request.setAttribute("endPage", endPage);
			request.getRequestDispatcher(eventMainPage).forward(request, response);
		}
		
		
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("POST Event Main");
		
		String actionType = request.getParameter("actionType");

		// if confirm delete 
		if(actionType.equals("delete")){
			int eveId = Integer.parseInt(request.getParameter("eventId"));
			List<ProfileUserModel> userList = evnManager.getRegisterUser(eveId);
			// if this event has registered user
			if(userList.size() > 0){
				request.setAttribute("msg", "This event has registered user!");
			}// if not 
			else{
				String res = evnManager.deleteEvent(eveId);
				if(res.equals(CommonConstants.RETURN_SUCCESS)){
					request.setAttribute("msg", "Event is deleted.");
				}
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
			
			String res = evnManager.createNewEvent(eventName, description, location, startDate, endDate, null, status, null);
			if(res.equals(CommonConstants.RETURN_SUCCESS)){
				request.setAttribute("msg", "Event is save successful.");
			}
			doGet(request, response);
			
		}// if confirm archive
		else if(actionType.equals("archive")){
			int eveId = Integer.parseInt(request.getParameter("eventId"));
			// if status is closed
			if(evnManager.checkArchiveRule(eveId)){
				
				//Archive
				String res = evnManager.updateStatus(eveId, "archive");
				if(res.equals(CommonConstants.RETURN_SUCCESS)){
					request.setAttribute("msg", "Event archive successful.");
				}
			}// if not
			else{
				request.setAttribute("msg", "This event's status must be closed!");
			}
			doGet(request, response);
		}// if open luckyDraw
		else if(actionType.equals("getLuckyList")){
			
			int eveId = Integer.parseInt(request.getParameter("eventId"));
			List<RegisterEventModel> luckyList = registerEventManager.getListByEveId(eveId);
			log.info("lucky list size = "+luckyList.size());
			
			String json = new Gson().toJson(luckyList);
			log.info(json);
		    response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(json);
			
		}// if post lucky result
		else if(actionType.equals("LuckyDraw")){
			log.info("Lucky Draw OK");
			int reeId = Integer.parseInt(request.getParameter("reeId"));
			String status = request.getParameter("status");
			String luckyStatus = "NO SHOW";
			
			if(status.equals("Y")){
				luckyStatus = "GOT PRIZE";
			}
			
			// update table register_event
			registerEventManager.updateLuckyStatus(reeId, status);
			// set object
			RegisterEventModel ree = registerEventManager.getReeById(reeId);
			// insert table luckydraw
			String result = luckyDrawManager.createNewLuckyDraw(ree, luckyStatus);
			
			response.setContentType("application/plain");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(result);
		}
	}
}
