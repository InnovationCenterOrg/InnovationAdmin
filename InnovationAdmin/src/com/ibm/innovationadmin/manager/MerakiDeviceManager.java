package com.ibm.innovationadmin.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.sql.DataSource;

import com.ibm.innovationadmin.constants.CommonConstants;
import com.ibm.innovationadmin.model.LuckyDrawModel;
import com.ibm.innovationadmin.model.MerakiModel;
import com.ibm.innovationadmin.model.ProfileUserModel;
import com.ibm.innovationadmin.model.RegisterEventModel;

@Stateless
@LocalBean
public class MerakiDeviceManager {
	private static final Logger log = Logger.getLogger(MerakiDeviceManager.class.getName()); 
	
	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;

	Connection connection = null;
	PreparedStatement pstmt = null;
	SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public MerakiDeviceManager(){

	}
	
	public List<MerakiModel> getListDistinctConnectedUser(Date startDate, Date endDate){
		
		List<MerakiModel> userList = getListByDateTime(startDate, endDate);
		List<MerakiModel> result = new ArrayList<MerakiModel>();
		Set<String> mac = new HashSet<String>();

		for( MerakiModel model : userList ) {
		    if( mac.add( model.getMedClientMac()) ) {
		        result.add( model );
		    }
		}
		return result;
		
	}

	public List<MerakiModel> getListByDateTime(Date startDate, Date endDate){
			
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("SELECT * FROM MERAKI_DEVICE ");
		sqlBuffer.append("WHERE MED_CREATE_DATE >= ? AND MED_CREATE_DATE <= ? ");
		
		Calendar cal = Calendar.getInstance();
		
		cal.setTime(startDate);
		cal.add(Calendar.HOUR_OF_DAY, -1);
		startDate = cal.getTime();
		
		cal.setTime(endDate);
		cal.add(Calendar.HOUR_OF_DAY, 1);
		endDate = cal.getTime();
		
		log.info("Start = "+dateTimeFormat.format(startDate));
		log.info("End = "+dateTimeFormat.format(endDate));
		
		List<MerakiModel> resultList = null;
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sqlBuffer.toString());
			pstmt.setString(1, dateTimeFormat.format(startDate));
			pstmt.setString(2, dateTimeFormat.format(endDate));
			
			
			ResultSet results = pstmt.executeQuery();
			MerakiModel med = null;
			resultList = new ArrayList();
			while(results.next()){
				med = new MerakiModel();
				med.setMedFbName(results.getString("MED_FB_NAME"));
				med.setMedFbEmail(results.getString("MED_FB_EMAIL"));
				med.setMedFbGender(results.getString("MED_FB_GENDER"));
				med.setMedOs(results.getString("MED_OS"));
				med.setMedClientMac(results.getString("MED_CLIENT_MAC"));
				resultList.add(med);
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
	
	
	
}

