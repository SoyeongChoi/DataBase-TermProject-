package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanTicket {

	private static LogonDBBeanTicket instance = new LogonDBBeanTicket();
	
	public static LogonDBBeanTicket getInstance() {
		return instance;
	}
	
	private LogonDBBeanTicket() {}
	
	private Connection getConnection() throws Exception{
		Connection conn = null;
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertTicket(LogonDataBeanTicket ticket) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into 티켓 values (?, ?, ?, ?)");
			String res[] = ticket.getPayCode().split("&");
			pstmt.setString(1, res[0]+"&"+res[1]+"&"+res[2]+"&"+res[3]+"&"+res[4]+"&"+res[5]+"&"+res[6]+"&"+res[7]);
			pstmt.setInt(2, 1);
			pstmt.setString(3, ticket.getSeatCode());
			pstmt.setString(4, ticket.getPayCode());
			
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	

	
	public String[][] getInfoAll() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from 결제");
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();
			
			Info = new String[count][7];
			System.out.println(count+"count:");
			
			int r=0; //행
			while(rs.next()) {
				Info[r][0] = rs.getString("결제코드");
				Info[r][1] = rs.getString("회원아이디");
				Info[r][2] = rs.getString("결제유형");
				Info[r][3] = rs.getString("좌석코드");
				Info[r][4] = rs.getString("상영일정코드");
				Info[r][5] = rs.getString("상영관아이디");
				Info[r][6] = rs.getString("영화아이디");
				r+=1;
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
	
	public boolean ExistTicket(String code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from 티켓 where 결제코드 = ?");
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			int count = 0;
			while(rs.next()) {
				count++;
			}
			if(count == 0) {
				return true;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return false;
	}
	
	public String[] getInfo(String mId) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[6];
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 결제 where 회원아이디 = ?");
			pstmt.setString(1, mId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
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
	
	public void deleteMovie(String mid) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         conn = getConnection();
	         pstmt = conn.prepareStatement("select 영화아이디 from 영화 where 영화아이디=?");
	            pstmt.setString(1, mid);
	            rs = pstmt.executeQuery();
	            
	            if(rs.next()){
	               String rId = rs.getString("영화아이디");
	               if(mid.equals(rId)){
	                  String sql = "delete from 영화 where 영화아이디 = ?";
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, mid);
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
