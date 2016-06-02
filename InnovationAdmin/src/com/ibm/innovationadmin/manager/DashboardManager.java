package com.ibm.innovationadmin.manager;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.sql.DataSource;

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.model.EventModel;
import com.ibm.innovationadmin.model.MerakiModel;
import com.ibm.innovationadmin.model.RegisterEventModel;

@Stateless
@LocalBean
public class DashboardManager {

	private static final Logger log = Logger.getLogger(DashboardManager.class.getName()); 
	
	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;

	Connection connection = null;
	PreparedStatement pstmt = null;
	SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public DashboardManager(){

	}

	//Search by crietria (eventName, eventStartDate, eventStatus)
	public List<MerakiModel> getDeviceList(Date eveStartDate, Date eveEndDate){
		List<MerakiModel> resultList = null;
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select med_client_mac, MAX(med_fb_id) as fb_id, med_fb_name, med_fb_gender, med_os from meraki_device ");
		// get all devices that connected fb in the event period.

		sqlBuffer.append("where med_client_mac != '' and med_fb_id != '' ");
		if(eveStartDate != null && eveEndDate != null){
			sqlBuffer.append("and med_create_date between ? and ? ");
		}
		sqlBuffer.append("group by med_client_mac, med_fb_name, med_fb_gender, med_os ");
		sqlBuffer.append("order by fb_id ");
		log.info(sqlBuffer+"");
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sqlBuffer.toString());

			if(eveStartDate != null && eveEndDate != null){
				pstmt.setDate(1, new java.sql.Date(eveStartDate.getTime()));
				pstmt.setDate(2, new java.sql.Date(eveEndDate.getTime()));
			}
			ResultSet results = pstmt.executeQuery();
			MerakiModel device = null;
			resultList = new ArrayList();
			while(results.next()){
				device = new MerakiModel();
				device.setMedFbId(results.getString("fb_id"));
				device.setMedFbName(results.getString("med_fb_name"));
				device.setMedClientMac(results.getString("med_client_mac"));
				log.info("Facebook Name : "+device.getMedFbName());
				resultList.add(device);
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
	public int getNumOfPersonByGender(String gender,Date eveStartDate, Date eveEndDate){
		List<MerakiModel> resultList = null;
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select med_client_mac, MAX(med_fb_id) as fb_id, med_fb_name, med_fb_gender, med_os from meraki_device ");

		sqlBuffer.append("where med_client_mac != '' and med_fb_id != '' ");
		if(gender != null && !gender.equals("")){
			sqlBuffer.append("and med_fb_gender = ? ");
		}
		if(eveStartDate != null && eveEndDate != null){
			sqlBuffer.append("and med_create_date between ? and ? ");
		}
		sqlBuffer.append("group by med_client_mac, med_fb_name, med_fb_gender, med_os ");
		sqlBuffer.append("order by fb_id ");
		log.info(sqlBuffer+"");
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sqlBuffer.toString());

			if(gender != null && !gender.equals("")){
				pstmt.setString(1,  gender );
			}
			if(eveStartDate != null && eveEndDate != null){
				pstmt.setDate(2, new java.sql.Date(eveStartDate.getTime()));
				pstmt.setDate(3, new java.sql.Date(eveEndDate.getTime()));
			}
			ResultSet results = pstmt.executeQuery();
			MerakiModel device = null;
			resultList = new ArrayList();
			while(results.next()){
				device = new MerakiModel();
				device.setMedFbId(results.getString("fb_id"));
				device.setMedClientMac(results.getString("med_client_mac"));
				resultList.add(device);
			}
			connection.close();
			return resultList.size();
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		
		return resultList.size();
	}
	
	public int getNumOfPersonByOS(String os,Date eveStartDate, Date eveEndDate){
		List<MerakiModel> resultList = null;
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select med_client_mac, MAX(med_fb_id) as fb_id, med_fb_name, med_fb_gender, med_os from meraki_device ");

		sqlBuffer.append("where med_client_mac != '' and med_fb_id != '' ");
		if(os != null && !os.equals("")){
			sqlBuffer.append("and med_os = ? ");
		}
		if(eveStartDate != null && eveEndDate != null){
			sqlBuffer.append("and med_create_date between ? and ? ");
		}
		sqlBuffer.append("group by med_client_mac, med_fb_name, med_fb_gender, med_os ");
		sqlBuffer.append("order by fb_id ");
		log.info(sqlBuffer+"");
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sqlBuffer.toString());

			if(os != null && !os.equals("")){
				pstmt.setString(1, os);
			}
			if(eveStartDate != null && eveEndDate != null){
				pstmt.setDate(2, new java.sql.Date(eveStartDate.getTime()));
				pstmt.setDate(3, new java.sql.Date(eveEndDate.getTime()));
			}
			ResultSet results = pstmt.executeQuery();
			MerakiModel device = null;
			resultList = new ArrayList();
			while(results.next()){
				device = new MerakiModel();
				device.setMedFbId(results.getString("fb_id"));
				device.setMedClientMac(results.getString("med_client_mac"));
				resultList.add(device);
			}
			connection.close();
			return resultList.size();
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		
		return resultList.size();
	}
	
}
