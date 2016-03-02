package com.ibm.innovationadmin.action;

import java.io.Console;
import java.io.IOException;
import java.util.ArrayList;
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
import com.ibm.innovationadmin.manager.DashboardManager;
import com.ibm.innovationadmin.manager.EventManager;
import com.ibm.innovationadmin.manager.ProfileUserManager;
import com.ibm.innovationadmin.model.EventModel;
import com.ibm.innovationadmin.model.MerakiModel;
import com.ibm.innovationadmin.model.ProfileUserModel;

public class DashboardDetailAction extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8579213088672797881L;

	@Resource(lookup = "jdbc/InnovationDatabase")
	DataSource ds;

	@EJB
	private DashboardManager dashboardManager;
	@EJB
	private EventManager eventManager;
	public static final long HOUR = 3600 * 1000;

	private static final Logger log = Logger
			.getLogger(DashboardDetailAction.class.getName());

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		log.info("TEST DOGET");
		// request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("TEST DOPOST");
		if (request.getSession().getAttribute("name") == null) {
			request.getRequestDispatcher("login.jsp")
					.forward(request, response);
		} else {
			String eventId = request.getParameter("selectedEveId");
			String dashboardStyle = request
					.getParameter("selectedDashboardStyle");
			String forwardUrl = "";
			EventModel event = eventManager.getEventById(Integer
					.valueOf(eventId));

			log.info("start date " + event.getEveStartDate().toString());
			log.info("end date " + event.getEveEndDate().toString());
			Date newStartDateTime = new Date(event.getEveStartDate().getTime()
					+ 1 * HOUR);
			Date newEndDateTime = new Date(event.getEveEndDate().getTime() + 1
					* HOUR);
			// log.info("new end date "+newDateTime.toString());
			List<MerakiModel> deviceList = dashboardManager.getDeviceList(
					newStartDateTime, newEndDateTime);
			System.out.println("Device List Size :" + deviceList.size());
			List<MerakiModel> facebookList = new ArrayList<MerakiModel>();
			MerakiModel device = new MerakiModel();
			List<String> others = new ArrayList<String>();
			if (deviceList.size() < 30) {
				int remaining = 30 - deviceList.size();
				int mod = 0;
				for (int i = 0; i < remaining; i++) {
					mod = i % 3;
					others.add("/images/IBM" + mod + ".png");
				}

			}
			/*
			 * MerakiDeviceModel ibmFB = new MerakiDeviceModel();
			 * ibmFB.setMedFbId(CommonConstants.IBM_FACEBOOK_ID); if
			 * (deviceList.size() <= 15) { int j = 30-(2*deviceList.size()); for
			 * (int i = 0 ; i < deviceList.size() ; i++){ device =
			 * deviceList.get(i); facebookList.add(device);
			 * facebookList.add(ibmFB); } for (int i = 0 ; i < j ; i++){
			 * facebookList.add(ibmFB); } } if (deviceList.size() > 15 &&
			 * deviceList.size() <= 30) { int j = 30-deviceList.size(); for (int
			 * i = 0 ; i < j ; i++){ device = deviceList.get(i);
			 * facebookList.add(device); facebookList.add(ibmFB); } for (int i =
			 * j; i < deviceList.size(); i++){ device = deviceList.get(i);
			 * facebookList.add(device); } }
			 */
			int numOfMale = dashboardManager.getNumOfPersonByGender(
					CommonConstants.FB_GENDER_MALE, newStartDateTime,
					newEndDateTime);
			int numOfFemale = dashboardManager.getNumOfPersonByGender(
					CommonConstants.FB_GENDER_FEMALE, newStartDateTime,
					newEndDateTime);

			int numOfWindows = dashboardManager.getNumOfPersonByOS(
					CommonConstants.DEVICE_OS_WINDOWS, newStartDateTime,
					newEndDateTime);
			int numOfApple = dashboardManager.getNumOfPersonByOS(
					CommonConstants.DEVICE_OS_APPLE, newStartDateTime,
					newEndDateTime);
			int numOfAndroid = dashboardManager.getNumOfPersonByOS(
					CommonConstants.DEVICE_OS_ANDROID, newStartDateTime,
					newEndDateTime);
			if (dashboardStyle.equals("IBM Cloud 3D")) {

				request.setAttribute("male", numOfMale);
				request.setAttribute("female", numOfFemale);
				request.setAttribute("windows", numOfWindows);
				request.setAttribute("apple", numOfApple);
				request.setAttribute("android", numOfAndroid);
				request.setAttribute("numOfDevices", deviceList.size());
				request.setAttribute("deviceList", deviceList);
				if (others.size() > 0) {
					request.setAttribute("otherList", others);
				}

				forwardUrl = "/view/dashboarddetail.jsp";
			}else {
				request.setAttribute("deviceList", deviceList);
				if (others.size() > 0) {
					request.setAttribute("otherList", others);
				}

				forwardUrl = "/view/dashboardworld.jsp";
			}
			
			
			request.getRequestDispatcher(forwardUrl).forward(request, response);

		}
	}

}
