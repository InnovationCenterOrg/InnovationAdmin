package com.ibm.innovationadmin.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.sql.DataSource;

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.model.ProfileUserModel;

@Stateless
@LocalBean
public class ProfileUserManager {

	private static final Logger log = Logger.getLogger(ProfileUserManager.class.getName()); 
	
	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;

	Connection connection = null;
	PreparedStatement pstmt = null;
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public ProfileUserManager(){
		
	}
	
	public ProfileUserModel authen(String username, String password){
		log.info("Authentication Method");
		String sql = "select * from profile_user where pro_username = ? and pro_password = ? and pro_role = 'Admin'";
		try{
			log.info("START QUERY");
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			
			log.info("TEST 1");
			
			ResultSet result = pstmt.executeQuery();
		
			log.info("TEST 2 : "+connection);
			
			ProfileUserModel user = null;
			while(result.next()){
				log.info("FOUND User");
				user = new ProfileUserModel();
				user.setProId(result.getInt("pro_id"));
				user.setProTitle(result.getString("pro_title"));
				user.setProFirstName(result.getString("pro_firstname"));
				user.setProLastName(result.getString("pro_lastname"));
				user.setProFullName(result.getString("pro_fullname"));
				user.setProCompanyName(result.getString("pro_company_name"));
				user.setProContactNo(result.getString("pro_contact_no"));
				user.setProEmail(result.getString("pro_email"));
				user.setProPassword(result.getString("pro_password"));
				user.setProRole(result.getString("pro_role"));				
				log.info("PRO_ID : "+user.getProId());
			}
			
			pstmt.close();
			return user;
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
			return null;
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
			return null;
		}
		
	}
	
	public String createNewProfileUser(ProfileUserModel user){
		
		String sql = "insert into profile_user (pro_title, pro_firstname, pro_lastname, pro_fullname, pro_company_name, pro_contact_no, pro_email, pro_username, pro_password, pro_role, pro_create_date) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try{
			log.info("START Create New ProfileUser");
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getProTitle().toUpperCase());
			pstmt.setString(2, user.getProFirstName().toUpperCase());
			pstmt.setString(3, user.getProLastName().toUpperCase());
			pstmt.setString(4, user.getProFullName().toUpperCase());
			pstmt.setString(5, user.getProCompanyName().toUpperCase());
			pstmt.setString(6, user.getProContactNo());
			pstmt.setString(7, user.getProEmail());
			pstmt.setString(8, user.getProUsername());
			pstmt.setString(9, user.getProPassword());
			pstmt.setString(10, user.getProRole());
			pstmt.setString(11, dateFormat.format(new Date()));
			
			log.info("STATEMENT : "+pstmt.toString());
			
			int result = pstmt.executeUpdate();
			log.info("FINISH Create New ProfileUser : "+result);
			
			pstmt.close();
			if(result > 0){
				//OK
				return CommonConstants.RETURN_SUCCESS;
			}
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
			
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
			
		}
		return CommonConstants.RETURN_FAIL;
		
	}
	
	public String updateProfileUserById(String proTitle, Integer proId, String proFirstName, String proLastName, String proFullName, String proCompanyName, String proContactNo, String proEmail, String proUsername, String proPassword){
		String sql = "update profile_user set pro_title=?, pro_firstname=?, pro_lastname=?, pro_fullname=?, pro_company_name=?, pro_contact_no=?, pro_email=?, pro_username=?, pro_password=? where pro_id=?";
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setString(1, proTitle.toUpperCase());
			pstmt.setString(2, proFirstName.toUpperCase());
			pstmt.setString(3, proLastName.toUpperCase());
			pstmt.setString(4, proFullName.toUpperCase());
			pstmt.setString(5, proCompanyName.toUpperCase());
			pstmt.setString(6, proContactNo);
			pstmt.setString(7, proEmail);
			pstmt.setString(8, proUsername);
			pstmt.setString(9, proPassword);
			pstmt.setInt(10, proId.intValue());
			
			int result = pstmt.executeUpdate();
			
			connection.close();
			
			if(result > 0){
				//OK
				return CommonConstants.RETURN_SUCCESS;
			}
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		
		return CommonConstants.RETURN_FAIL;
		
	}
	
	public List<ProfileUserModel> getProfileUserList(String keyword){
			List<ProfileUserModel> resultList = null;
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append("select * from profile_user ");
			if(keyword != null && !keyword.equals("")){
				sqlBuffer.append("where pro_fullname like ? ");
			}
			
			try{
				connection = ds.getConnection();
				pstmt = connection.prepareStatement(sqlBuffer.toString());
				if(keyword != null && !keyword.equals("")){
					pstmt.setString(1, "%"+keyword.toUpperCase()+"%");
				}

				
				ResultSet results = pstmt.executeQuery();
				ProfileUserModel user = null;
				resultList = new ArrayList();
				while(results.next()){
					user = new ProfileUserModel();
					user.setProId(results.getInt("pro_id"));
					user.setProTitle(results.getString("pro_title"));
					user.setProFirstName(results.getString("pro_firstname"));
					user.setProLastName(results.getString("pro_lastname"));
					user.setProFullName(results.getString("pro_fullname"));
					user.setProCompanyName(results.getString("pro_company_name"));
					user.setProContactNo(results.getString("pro_contact_no"));
					user.setProEmail(results.getString("pro_email"));
					user.setProUsername(results.getString("pro_username"));
					user.setProPassword(results.getString("pro_password"));
					user.setProRole(results.getString("pro_role"));		
					resultList.add(user);
				}
				connection.close();
				return resultList;
				
			}catch(SQLException e1){
				log.info("SQL ERROR : "+e1.getMessage());
			}catch(Exception e2){
				log.info("ERROR : "+e2.getMessage());
			}
			
			return resultList;
		}
	
	public ProfileUserModel getProfileUserById(Integer proId){
		ProfileUserModel user = null;
		String sql = "select * from profile_user where pro_id = ?";
		try{

			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, proId);
			ResultSet result = pstmt.executeQuery();
			while (result.next()){
				
				user = new ProfileUserModel();
				user.setProId(result.getInt("pro_id"));
				user.setProTitle(result.getString("pro_title"));
				user.setProFirstName(result.getString("pro_firstname"));
				user.setProLastName(result.getString("pro_lastname"));
				user.setProFullName(result.getString("pro_fullname"));
				user.setProCompanyName(result.getString("pro_company_name"));
				user.setProContactNo(result.getString("pro_contact_no"));
				user.setProEmail(result.getString("pro_email"));
				user.setProUsername(result.getString("pro_username"));
				user.setProPassword(result.getString("pro_password"));
				user.setProRole(result.getString("pro_role"));				
				log.info("PRO_ID : "+user.getProId());
			}
			
			connection.close();
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR "+e2.getMessage());
		}
		
		
		return user;
	}
	
	public boolean isDuplicateUsername(String username){
		boolean returnresult = true;
		String sql = "select * from profile_user where pro_username = ?";
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, username);
			
			ResultSet result = pstmt.executeQuery();
			
			while(result.next()){
				//Found Duplicate
				returnresult = false;
				
			}
			connection.close();
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		return returnresult;
		
	}
	
	public String changePassword(Integer proId, String proPassword){
		String sql = "update profile_user set pro_password=? where pro_id=?";
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setString(1, proPassword);
			pstmt.setInt(2, proId.intValue());
			
			int result = pstmt.executeUpdate();
			
			connection.close();
			
			if(result > 0){
				//OK
				return CommonConstants.RETURN_SUCCESS;
			}
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		
		return CommonConstants.RETURN_FAIL;
		
	}
	
}
