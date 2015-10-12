package com.web.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.web.entity.PhysicianItem;
import com.web.entity.QuestionItem;

public class ServiceWrapper {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public List<PhysicianItem> getPhysicians() {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		List<PhysicianItem> list = new ArrayList<PhysicianItem>();
		try {
			conn = dataSource.getConnection();
			st = conn.prepareStatement("select * from physician");
			rs = st.executeQuery();
			while (rs.next()) {
				PhysicianItem item = new PhysicianItem();
				item.setId(rs.getLong("PhysicianID"));
				item.setFirstname(rs.getString("FirstName"));
				item.setLastname(rs.getString("LastName"));
				item.setAddress(rs.getString("Address"));
				item.setPhone(rs.getString("PhoneNumber"));
				item.setEmail(rs.getString("EmailAddress"));
				item.setSpecId(rs.getLong("SpecID"));
				item.setDeptId(rs.getLong("DeptID"));
				item.setUsername(rs.getString("UserName"));
				item.setPassword(rs.getString("Password"));
				item.setFirstLogin(DbUtils.getBoolean(rs, "FirstLogin"));
				item.setActive(DbUtils.getBoolean(rs, "Active"));
				list.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		return list;
	}

	public String addPhysician(Long id, String firstname, String lastname,
			String address, String phone, String email, Long specId,
			Long deptId, String username, String password) {
		String result = null;
		Connection conn = null;
		PreparedStatement st = null;
		try {
			conn = dataSource.getConnection();
			if(id == null){
				st = conn.prepareStatement("insert into physician (FirstName, LastName, Address, PhoneNumber, EmailAddress, SpecID, DeptID ,"
					+ "UserName, Password, FirstLogin, Active) values (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, 1) ");
			}else {
				st = conn.prepareStatement("update physician set FirstName = ?, LastName =? , Address = ?, PhoneNumber = ?, EmailAddress= ?, "
						+ "SpecID =? , DeptID = ? , UserName = ?, Password = ? where PhysicianID = ? ");
			}
			st.setString(1, firstname);
			st.setString(2, lastname);
			st.setString(3, address);
			st.setString(4, phone);
			st.setString(5, email);
			DbUtils.setNumber(st, 6, specId);
			DbUtils.setNumber(st, 7, deptId);
			st.setString(8, username);
			st.setString(9, password);
			if(id != null){
				DbUtils.setNumber(st, 10, id);
			}
			st.executeUpdate();
		} catch (Exception e) {
			result = e.getMessage();
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(st);
		}
		return result;
	}

	public void deletePhysicianById(Long id) {
		Connection conn = null;
		PreparedStatement st = null;
		try {
			conn = dataSource.getConnection();
			st = conn.prepareStatement("update physician set active = 0 where PhysicianID = ? ");
			DbUtils.setNumber(st, 1, id);
			st.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(st);
		}
	}

	public PhysicianItem getPhysicianById(Long id) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		PhysicianItem item = new PhysicianItem();
		try {
			conn = dataSource.getConnection();
			st = conn.prepareStatement("select * from physician where PhysicianID = ?");
			DbUtils.setNumber(st, 1, id);
			rs = st.executeQuery();
			if (rs.next()) {
				item.setId(rs.getLong("PhysicianID"));
				item.setFirstname(rs.getString("FirstName"));
				item.setLastname(rs.getString("LastName"));
				item.setAddress(rs.getString("Address"));
				item.setPhone(rs.getString("PhoneNumber"));
				item.setEmail(rs.getString("EmailAddress"));
				item.setSpecId(rs.getLong("SpecID"));
				item.setDeptId(rs.getLong("DeptID"));
				item.setUsername(rs.getString("UserName"));
				item.setPassword(rs.getString("Password"));
				item.setFirstLogin(DbUtils.getBoolean(rs, "FirstLogin"));
				item.setActive(DbUtils.getBoolean(rs, "Active"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		return item;
	}
	
	//get random 5 question for first login
	public List<QuestionItem> getQuestions(long limit) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		List<QuestionItem> list = new ArrayList<QuestionItem>();
		try {
			conn = dataSource.getConnection();
			st = conn.prepareStatement("SELECT * FROM question ORDER BY RAND() LIMIT ?");
			st.setLong(1, limit);
			rs = st.executeQuery();
			long order = 1;
			while (rs.next()) {
				QuestionItem item = new QuestionItem();
				item.setId(rs.getLong("QuestionID"));
				item.setOrder(order);
				item.setContent(rs.getString("Content"));
				list.add(item);
				order++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		return list;
	}

	public void saveFirstAnswer(String name, List<QuestionItem> listData) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		Long userID = null; 
		try {
			conn = dataSource.getConnection();
			//select user id
			st = conn.prepareStatement("SELECT PhysicianID FROM physician where username = ?");
			st.setString(1, name);
			rs = st.executeQuery();
			if (rs.next()) {
				userID = rs.getLong(1);
			}
			rs.close();
			st.close();
			
			if(userID != null){
				//update first login
				st = conn.prepareStatement("update physician set FirstLogin = 0 where PhysicianID = ?");
				st.setLong(1, userID);
				st.executeUpdate();
				rs.close();
				st.close();
				
				//insert into answer
				for (QuestionItem questionItem : listData) {
					st = conn.prepareStatement("insert into answer values (?,?,?)");
					st.setLong(1, questionItem.getId());
					st.setLong(2, userID);
					st.setString(3, questionItem.getAnswer());
					st.executeUpdate();
					rs.close();
					st.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		
	}

	public boolean saveNotFirstAnswer(String name, List<QuestionItem> listData) {
		boolean result = false;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		Long userID = null; 
		try {
			conn = dataSource.getConnection();
			//select user id
			st = conn.prepareStatement("SELECT PhysicianID FROM physician where username = ?");
			st.setString(1, name);
			rs = st.executeQuery();
			if (rs.next()) {
				userID = rs.getLong(1);
			}
			rs.close();
			st.close();
			
			if(userID != null){
				//insert into answer
				for (QuestionItem questionItem : listData) {
					st = conn.prepareStatement("select * from answer where QuestonID = ? and PhysicianID = ? and UPPER(content) = ?");
					st.setLong(1, questionItem.getId());
					st.setLong(2, userID);
					st.setString(3, questionItem.getAnswer().trim().toUpperCase());
					rs = st.executeQuery();
					if(rs.next()){
						result = true;
						break;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		return result;
		
	}
}
