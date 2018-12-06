package login;

public class LogonDataBeanTicket {
	private String payCode; //���̵�
	private String id; //��й�ȣ
	private String payType; //����
	private String seatCode; //�������
	private String screenScheduleCode; //ȸ���ּ�
	private String screenId; //ȸ����ȭ��ȣ
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPayCode() {
		return payCode;
	}
	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType= payType;
	}
	public String getSeatCode() {
		return seatCode;
	}
	public void setSeatCode(String seatCode) {
		this.seatCode = seatCode;
	}
	public String getScreenScheduleCode() {
		return screenScheduleCode;
	}
	public void setScreenScheduleCode(String screenScheduleCode) {
		this.screenScheduleCode = screenScheduleCode;
	}
	public String getScreenId() {
		return screenId;
	}
	public void setScreenId(String screenId) {
		this.screenId = screenId;
	}
}
