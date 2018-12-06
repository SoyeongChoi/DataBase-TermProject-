package login;
import java.sql.*;

public class LogonDBBean {
	
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private LogonDBBean() {}
	
	private Connection getConnection() throws Exception{
		Connection conn = null;
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "thdud5313";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into 회원 values (?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getBirth());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getPhoneNum());
			pstmt.setInt(7, 0);
			pstmt.setString(8, "일반");
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	public void updateMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("update 회원 set 비밀번호 = ?, 성명 = ?, 생년월일 = ?,회원주소 = ?,회원전화번호 = ? where 회원아이디 = ?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setInt(3, member.getBirth());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getPhoneNum());
			pstmt.setString(6, member.getId());
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
		String Info[] = new String[7];
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 회원 where 회원아이디 = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Info[0] = rs.getString("비밀번호");
				Info[1] = rs.getString("성명");
				Info[2] = Integer.toString(rs.getInt("생년월일"));
				Info[3] = rs.getString("회원주소");
				Info[4] = rs.getString("회원전화번호");
				Info[5] = Integer.toString(rs.getInt("point"));
				Info[6] = rs.getString("회원등급");
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
	
	public void deleteMember(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         conn = getConnection();
	         pstmt = conn.prepareStatement("select 회원아이디 from 회원 where 회원아이디=?");
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	            
	            if(rs.next()){
	               String rId = rs.getString("회원아이디");
	               if(id.equals(rId)){
	                  String sql = "delete from 회원 where 회원아이디 = ?";
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
	
	public int userCheck(String id, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select 비밀번호 from 회원 where 회원아이디 = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("비밀번호");
				if(dbpasswd.equals(passwd))
					x = 1;
				else
					x = 0;
			}else
				x = -1;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return x;
	}
	
	public int managerCheck(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbgrade = "";
		System.out.println("id"+id);
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select 회원등급 from 회원 where 회원아이디 = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbgrade = rs.getString("회원등급");
				if(dbgrade.equals("관리자"))
					x = 1;
				else
					x = 0;
			}else
				x = -1;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return x;
	}
}
