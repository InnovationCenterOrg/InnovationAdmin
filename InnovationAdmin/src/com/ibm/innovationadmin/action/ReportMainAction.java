package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
import java.util.Calendar;
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

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.manager.AuthenticationManager;
import com.ibm.innovationadmin.manager.EventManager;
import com.ibm.innovationadmin.manager.MerakiDeviceManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.EventModel;
import com.ibm.innovationadmin.model.MerakiModel;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class ReportMainAction extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/InnovationDatabase")
	DataSource ds;
	
	@EJB
	private ProfileUserManager profileUserManager;
	
	@EJB 
	private EventManager eventManager;
	
	@EJB
	private MerakiDeviceManager merakiManager;
	
	private static final Logger log = Logger.getLogger(ReportMainAction.class.getName()); 

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("GET REPORT");
		if(request.getSession().getAttribute("name") == null){
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else{
			String reportId = request.getParameter("reportId");
			
			// First page
			if(reportId == null){
				request.getRequestDispatcher("/view/report.jsp").forward(request, response);
			}
			
			// Event Summary Information
			else if(reportId.equals("1")){
				Calendar cal = Calendar.getInstance();
				Integer month = cal.get(Calendar.MONTH)+1;
				Integer year = cal.get(Calendar.YEAR);
				if(request.getParameter("month") != null && request.getParameter("year") != null){
					month = Integer.parseInt(request.getParameter("month"));
					year = Integer.parseInt(request.getParameter("year"));
				}
				
				int page = 1;
				if(request.getParameter("page") != null){
					page = Integer.parseInt(request.getParameter("page"));
				}
				List<EventModel> eventList = eventManager.getEventList(null, month, year, null);
				request.setAttribute("month", month);
				request.setAttribute("year", year);
				
				int size = CommonConstants.PAGING;
				int from = Math.max(0,(page-1)*size);
				int to = Math.min(eventList.size(),page*size);
				
				List<EventModel> eventPaging = eventList.subList(from, to);
				
				int endPage = (int) Math.ceil((double) eventList.size() / size);
				
				request.setAttribute("eventSize", eventList.size());
				request.setAttribute("eventList", eventPaging);
				request.setAttribute("startPage", 1);
				request.setAttribute("endPage", endPage);
				request.getRequestDispatcher("/view/eventSummary.jsp").forward(request, response);
			}
			
			//Event Detail Information
			else if(reportId.equals("2")){
				
				if(request.getParameter("eventId") != null){
					Integer eventId = Integer.parseInt(request.getParameter("eventId"));
					List<ProfileUserModel> userList = eventManager.getRegisterUser(eventId);
					EventModel eventDetail = eventManager.getEventById(eventId);
					
					int page = 1;
					if(request.getParameter("page") != null){
						page = Integer.parseInt(request.getParameter("page"));
					}
					
					int size = CommonConstants.PAGING;
					int from = Math.max(0,(page-1)*size);
					int to = Math.min(userList.size(),page*size);
					
					List<ProfileUserModel> userPaging = userList.subList(from, to);
					
					int endPage = (int) Math.ceil((double) userList.size() / size);
					
					
					request.setAttribute("userSize", userList.size());
					request.setAttribute("userList", userPaging);
					request.setAttribute("eventDetail", eventDetail);
					request.setAttribute("startPage", 1);
					request.setAttribute("endPage", endPage);
				}
				
				List<EventModel> eventOption = eventManager.getEventList(null, null, null, null);
				request.setAttribute("eventOption", eventOption);
				request.getRequestDispatcher("/view/eventDetailInfo.jsp").forward(request, response);
			}
			
			//Event Wifi Connected User
			else if(reportId.equals("3")){
				
				if(request.getParameter("eventId") != null){
					Integer eventId = Integer.parseInt(request.getParameter("eventId"));
					
					EventModel eventDetail = eventManager.getEventById(eventId);
					// Edit get list miraki
					List<MerakiModel> userList = merakiManager.getListDistinctConnectedUser(eventDetail.getEveStartDate(), eventDetail.getEveEndDate());
					
					int page = 1;
					if(request.getParameter("page") != null){
						page = Integer.parseInt(request.getParameter("page"));
					}
					
					int size = CommonConstants.PAGING;
					int from = Math.max(0,(page-1)*size);
					int to = Math.min(userList.size(),page*size);
					
					List<MerakiModel> userPaging = userList.subList(from, to);
					
					int endPage = (int) Math.ceil((double) userList.size() / size);
					
					
					request.setAttribute("userSize", userList.size());
					request.setAttribute("userList", userPaging);
					request.setAttribute("eventDetail", eventDetail);
					request.setAttribute("startPage", 1);
					request.setAttribute("endPage", endPage);
				}
				
				List<EventModel> eventOption = eventManager.getEventList(null, null, null, null);
				request.setAttribute("eventOption", eventOption);
				request.getRequestDispatcher("/view/eventWifiConnected.jsp").forward(request, response);
				
			}
		}
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		
		String forwardUrl = "/view/report.jsp";

		request.getRequestDispatcher(forwardUrl).forward(request, response);
		
	}
		
}
