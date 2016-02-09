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
		log.info("GET User List");
		String keyword = request.getParameter("keyword"); 
		int page = 1;
		if(request.getParameter("page") != null){
			page = Integer.parseInt(request.getParameter("page"));
		}
		List<ProfileUserModel> usrList = profileUserManager.getProfileUserList(keyword);
		
		int size = CommonConstants.PAGING;
		int from = Math.max(0,(page-1)*size);
		int to = Math.min(usrList.size(),page*size);
		List<ProfileUserModel> usrPaging = usrList.subList(from, to);
		
		int endPage = (int) Math.ceil((double) usrList.size() / size);
		
		request.setAttribute("userList", usrPaging);
		request.setAttribute("startPage", 1);
		request.setAttribute("endPage", endPage);
		request.getRequestDispatcher(forwardUrl).forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		log.info("POST User");
		String actionType = request.getParameter("actionType");
		
		// if confirm reset password
		if(actionType.equals("resetpwd")){
			
			int proId = Integer.parseInt(request.getParameter("proId"));
			log.info("Reset PWD");
			profileUserManager.changePassword(proId, CommonConstants.DEFAULT_PASSWORD);
			request.setAttribute("msg", CommonConstants.DEFAULT_PASSWORD);
			doGet(request,response);
			
		}// if click add button
		else if(actionType.equals("redirectAdd")){
			
			request.setAttribute("type", "Add");
			request.getRequestDispatcher(editUser).forward(request, response);
			
		}//call from ajax to check username
		else if(actionType.equals("check")){
			
			String username = request.getParameter("username");
			boolean duplicate = profileUserManager.isDuplicateUsername(username);
			PrintWriter out = response.getWriter();
			out.write(duplicate+"");
			
		}// if submit form add user
		else if(actionType.equals("add")){
			
			String title = request.getParameter("title");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String fullName = firstName +" "+ lastName;
			String company = request.getParameter("company");
			String contactNo = request.getParameter("contactNo");
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String role = request.getParameter("role");
			
			profileUserManager.createNewProfileUser(title, firstName, lastName, fullName, company, contactNo, email, username, password, role);
			doGet(request, response);
			
		}
		
		
	}
		
}
