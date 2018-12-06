package login;
import java.sql.Timestamp;

public class LogonDataBeanReservation {
	private String Rcode;
	private String member_id; 
	private String Scode;
	private String schedule_code;
	private String screen_id;
	
	public String getMId() {
		return member_id;
	}
	public void setId(String id) {
		this.member_id = id;
	}
	public String getSchedule_code() {
		return schedule_code;
	}
	public void setSchedule_code(String schedule_code) {
		this.schedule_code = schedule_code;
	}
	public String getScreen_id() {
		return screen_id;
	}
	public void setScreen_id(String screen_id) {
		this.screen_id = screen_id;
	}
	public String getRcode() {
		return Rcode;
	}
	public void setRcode(String rcode) {
		this.Rcode = rcode;
	}
	public String getScode() {
		return Scode;
	}
	public void setScode(String scode) {
		this.Scode = scode;
	}
	
}
