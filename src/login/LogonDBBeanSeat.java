package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBeanSeat {

   private static LogonDBBeanSeat instance = new LogonDBBeanSeat();

   public static LogonDBBeanSeat getInstance() {
      return instance;
   }

   private LogonDBBeanSeat() {
   }

   private Connection getConnection() throws Exception {
      Connection conn = null;

      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";

      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      return conn;
   }

   public void insertSeat(LogonDataBeanSeat seat) throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;

      try {
         conn = getConnection();

         pstmt = conn.prepareStatement("insert into 좌석 values (?, ?, ?, ?)");
         pstmt.setString(1, seat.getSeat_code());
         pstmt.setInt(2, 1);
         pstmt.setString(3, seat.getScreen_id());
         pstmt.setString(4, seat.getSchedule_code());
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
   
   public String getInfo(String screen_id, String time_code) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int x = -1;
      String seatcode = null;
      
      try {
         conn = getConnection();
         pstmt = conn.prepareStatement("select * from 영화관 where 상영관아이디= ?, 상영일정코드 = ?");
         pstmt.setString(1, screen_id);
         pstmt.setString(2, time_code);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            seatcode = rs.getString("좌석코드");
         }else {
            
         }
      
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         if(rs != null) try {rs.close();} catch(SQLException ex) {}
         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
         if(conn != null) try {conn.close();} catch(SQLException ex) {}
      }
      return seatcode;
   }

   }