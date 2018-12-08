package login;
import java.sql.*;

public class LogonDBBeanReservation {
   private static LogonDBBeanReservation instance = new LogonDBBeanReservation();
   
   public static LogonDBBeanReservation getInstance() {
      return instance;
   }
   
   private LogonDBBeanReservation() {}
   
   private Connection getConnection() throws Exception{
      Connection conn = null;
      
      String jdbcUrl = "jdbc:mysql://localhost:3306/reservation_system?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPass = "thdud5313";
      
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      return conn;
   }
   public void insertReservation(LogonDataBeanReservation reservation) throws Exception{
      Connection conn = null;
         PreparedStatement pstmt = null;
         
         try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("insert into 예약 values (?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, reservation.getRcode());
            pstmt.setString(2, reservation.getMId());
            pstmt.setString(3, reservation.getScode());
            pstmt.setString(4, reservation.getSchedule_code());
            pstmt.setString(5, reservation.getScreen_id());
            pstmt.setString(6, reservation.getMovieId());
            pstmt.executeUpdate();
         }catch(Exception ex) {
            ex.printStackTrace();
         }finally {
            if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
            if(conn != null) try {conn.close();} catch(SQLException ex) {}
         }
   }
   public int CountMovie(String sId) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int count = 0;
      int x = -1;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select count(상영관아이디) from 예약 where 상영관아이디=?");
         pstmt.setString(1, sId);
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            count = Integer.parseInt(rs.getString(1));
         }
         
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         if(rs != null) try {rs.close();} catch(SQLException ex) {}
         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
         if(conn != null) try {conn.close();} catch(SQLException ex) {}
      }
      return count;
   }
   public int CountReservation() throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int count = 0;
      int x = -1;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select count(*) from 예약");
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            count = Integer.parseInt(rs.getString(1));
         }
         
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally {
         if(rs != null) try {rs.close();} catch(SQLException ex) {}
         if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
         if(conn != null) try {conn.close();} catch(SQLException ex) {}
      }
      return count;
   }

   
}