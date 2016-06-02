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
import com.ibm.innovationadmin.model.LuckyDrawModel;
import com.ibm.innovationadmin.model.ProfileUserModel;
import com.ibm.innovationadmin.model.RegisterEventModel;

@Stateless
@LocalBean
public class LuckyDrawManager {
	private static final Logger log = Logger.getLogger(LuckyDrawManager.class.getName()); 
	
	@Resource(lookup = "jdbc/dashDB-mf")
	DataSource ds;

	Connection connection = null;
	PreparedStatement pstmt = null;
	SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public LuckyDrawManager(){

	}
	
	public String createNewLuckyDraw(RegisterEventModel reeObj, String lucStatus){
		String sql = "insert into lucky_draw (luc_eve_id, luc_lucky_no, luc_ree_id, luc_status, luc_create_date) values (?,?,?,?,?) ";
		
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setInt(1, reeObj.getReeEveId().intValue());
			pstmt.setInt(2, reeObj.getReeLuckyNo());
			pstmt.setInt(3, reeObj.getReeId().intValue());
			pstmt.setString(4, lucStatus);
			pstmt.setString(5, dateTimeFormat.format(new Date()));
			
			int result = pstmt.executeUpdate();
			connection.close();
			
			if(result > 0){
				return CommonConstants.RETURN_SUCCESS;
			}
			
		}catch(SQLException e1){
			log.info("SQL ERROR : "+e1.getMessage());
		}catch(Exception e2){
			log.info("ERROR : "+e2.getMessage());
		}
		return CommonConstants.RETURN_FAIL;
	}
	
	public List<LuckyDrawModel> getListByEveId(Integer reeEveId){
			
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("SELECT * FROM LUCKY_DRAW INNER JOIN register_event ");
		sqlBuffer.append("ON LUC_LUCKY_NO = REE_LUCKY_NO AND LUC_EVE_ID = ? "); 
		sqlBuffer.append("INNER JOIN profile_user ON ree_pro_id = pro_id");
		
		List<LuckyDrawModel> resultList = null;
		try{
			connection = ds.getConnection();
			pstmt = connection.prepareStatement(sqlBuffer.toString());
			pstmt.setInt(1, reeEveId.intValue());
			
			ResultSet results = pstmt.executeQuery();
			LuckyDrawModel luc = null;
			resultList = new ArrayList();
			while(results.next()){
				luc = new LuckyDrawModel();
				luc.setProFullName(results.getString("pro_fullname"));
				luc.setLucLuckyNo(results.getInt("LUC_LUCKY_NO"));
				luc.setLucStatus(results.getString("LUC_STATUS"));
				resultList.add(luc);
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

