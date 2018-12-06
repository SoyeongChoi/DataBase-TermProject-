package login;

public class LogonDataBeanSeat {
	 private String seat_code;
	   private int check;
	   private String screen_id;
	   private String schedule_code;
	public String getSeat_code() {
		return seat_code;
	}
	public void setSeat_code(String seat_code) {
		this.seat_code = seat_code;
	}
	public int isReservation() {
		return check;
	}
	public void setReservation(int reservation) {
		this.check = reservation;
	}
	public String getScreen_id() {
		return screen_id;
	}
	public void setScreen_id(String screen_id) {
		this.screen_id = screen_id;
	}
	public String getSchedule_code() {
		return schedule_code;
	}
	public void setSchedule_code(String schedule_code) {
		this.schedule_code = schedule_code;
	}
	   
	   
}
