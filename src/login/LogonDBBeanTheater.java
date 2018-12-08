package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanTheater {

	private static LogonDBBeanTheater instance = new LogonDBBeanTheater();

	public static LogonDBBeanTheater getInstance() {
		return instance;
	}

	private LogonDBBeanTheater() {
	}

	private Connection getConnection() throws Exception {
		Connection conn = null;

		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "Lovedkwjd23@";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertTheater(LogonDataBeanTheater theater) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into 영화관 values (?, ?, ?)");
			pstmt.setString(1, theater.getmName());
			pstmt.setString(2, theater.getmAddress());
			pstmt.setString(3, theater.getmTelephone());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}

		}
	}

	public void updateTheater(LogonDataBeanTheater theater) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      
	      
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("update 영화관 set 영화관주소 = ?, 영화관전화번호 = ? where 영화관이름 = ?");
	         pstmt.setString(1, theater.getmAddress());
	         System.out.println(theater.getmAddress());
	         pstmt.setString(2, theater.getmTelephone());
	         System.out.println(theater.getmTelephone());
	         pstmt.setString(3, theater.getmName());
	         System.out.println(theater.getmName());
	         pstmt.executeUpdate();
	      }catch(Exception ex) {
	         ex.printStackTrace();
	      }finally {
	         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
	         if(conn != null) try {conn.close();} catch(SQLException ex) {}
	      }
	   }
	  
	public String[] getInfo(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[2];
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 영화관 where 영화관이름= ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Info[0] = rs.getString("영화관주소");
				Info[1] = rs.getString("영화관전화번호");
			}else {
				
			}
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return Info;
	}
	
	public void deleteTheater(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         conn = getConnection();
	         pstmt = conn.prepareStatement("select 영화관이름 from 영화관 where 영화관이름=?");
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	            
	            if(rs.next()){
	               String rId = rs.getString("영화관이름");
	               if(id.equals(rId)){
	                  String sql = "delete from 영화관 where 영화관이름 = ?";
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, id);
	                  pstmt.executeUpdate();
	               }
	            }
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if (pstmt != null)
	            try {
	               pstmt.close();
	            } catch (SQLException ex) {
	            }
	         if (conn != null)
	            try {
	               conn.close();
	            } catch (SQLException ex) {
	            }
	      } 
	   }
	
	}
