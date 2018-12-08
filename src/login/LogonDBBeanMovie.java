package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanMovie {

	private static LogonDBBeanMovie instance = new LogonDBBeanMovie();
	
	public static LogonDBBeanMovie getInstance() {
		return instance;
	}
	
	private LogonDBBeanMovie() {}
	
	private Connection getConnection() throws Exception{
		Connection conn = null;
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
		String dbId = "root";
		String dbPass = "Lovedkwjd23@";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		return conn;
	}

	public void insertMovie(LogonDataBeanMovie movie) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into 영화 values (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, movie.getmId());
			pstmt.setString(2, movie.getmTitle());
			pstmt.setString(3, movie.getmDirector());
			pstmt.setString(4, movie.getmActor());
			pstmt.setInt(5, movie.getmRating());
			pstmt.setString(6, movie.getmDetail());
			pstmt.setInt(7, 0); //예매율
			pstmt.setString(8, movie.getmStartDate());
			pstmt.setString(9, movie.getmEndDate());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	public void updateMovie(LogonDataBeanMovie movie) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("update 영화 set 영화제목 = ?, 감독 = ?, 출연 = ?, 등급 = ?, 주요정보 = ?, 예매율 =?, 시작날짜 =?, 종료날짜=? where 영화아이디 = ?");
			pstmt.setString(1, movie.getmTitle());
			pstmt.setString(2, movie.getmDirector());
			pstmt.setString(3, movie.getmActor());
			pstmt.setInt(4, movie.getmRating());
			pstmt.setString(5, movie.getmDetail());
			pstmt.setFloat(6, movie.getmBookingRate());
			pstmt.setString(7, movie.getmStartDate());
			pstmt.setString(8, movie.getmEndDate());
			pstmt.setString(9, movie.getmId());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	public void updateMovie(String movie, float f) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update 영화 set 예매율 = ? where 영화아이디 = ?");
			pstmt.setFloat(1, f);
			pstmt.setString(2, movie);
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
	
	public String[][] getInfoAll() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Info[][] = null;
		int x = -1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from 영화");
			rs = pstmt.executeQuery();
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();
			
			Info = new String[count][9];
			
			int r=0; //행
			while(rs.next()) {
				Info[r][0] = rs.getString("영화아이디");
				Info[r][1] = rs.getString("영화제목");
				Info[r][2] = rs.getString("감독");
				Info[r][3] = rs.getString("출연");
				Info[r][4] = Integer.toString(rs.getInt("등급"));
				Info[r][5] = rs.getString("주요정보");
				Info[r][6] = Float.toString(rs.getFloat("예매율"));
				Info[r][7] = rs.getString("시작날짜");
				Info[r][8] = rs.getString("종료날짜"); 
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
	
	public String[] getInfo(String mId) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String Info[] = new String[8];
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from 영화 where 영화아이디 = ?");
			pstmt.setString(1, mId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Info[0] = rs.getString("영화제목");
				Info[1] = rs.getString("감독");
				Info[2] = rs.getString("출연");
				Info[3] = Integer.toString(rs.getInt("등급"));
				Info[4] = rs.getString("주요정보");
				Info[5] = Float.toString(rs.getFloat("예매율"));
				Info[6] = rs.getString("시작날짜");
				Info[7] = rs.getString("종료날짜");
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
	      PreparedStatement pstmt2 = null;
	      PreparedStatement pstmt3 = null;
	      
	      ResultSet rs = null;
	      ResultSet rs2 = null;

	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from 상영관 where 영화아이디=?");
             pstmt.setString(1, mid);
	         rs = pstmt.executeQuery();
	         while(rs.next()){
	        	 System.out.println(rs.getString("상영관아이디"));
	        	 pstmt2 = conn.prepareStatement("delete from 상영일정 where 상영관아이디=?");
	             pstmt2.setString(1, rs.getString("상영관아이디"));
	             pstmt2.executeUpdate();
	         }
	         
	            
	         pstmt3 = conn.prepareStatement("select 영화아이디 from 영화 where 영화아이디=?");
	            pstmt3.setString(1, mid);
	            rs = pstmt3.executeQuery();
	            
	            if(rs.next()){
	               String rId = rs.getString("영화아이디");
	               if(mid.equals(rId)){
	                  String sql = "delete from 영화 where 영화아이디 = ?";
	                  pstmt3 = conn.prepareStatement(sql);
	                  pstmt3.setString(1, mid);
	                  pstmt3.executeUpdate();
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
	
	public String[] getDate(String mId){
	   	Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      int x = -1;
	      String date[] = new String[2];
	      try {
	         conn = getConnection();
	         pstmt = conn.prepareStatement("select 시작날짜, 종료날짜 from 영화 where 영화아이디 = ?");
	         pstmt.setString(1, mId);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            date[0] = rs.getString("시작날짜");
	            date[1] = rs.getString("종료날짜");
	         }else {
	            
	         }
	      
	      }catch(Exception ex) {
	         ex.printStackTrace();
	      }finally {
	         if(rs != null) try {rs.close();} catch(SQLException ex) {}
	         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
	         if(conn != null) try {conn.close();} catch(SQLException ex) {}
	      }
	      
	      return date;
   }


}
