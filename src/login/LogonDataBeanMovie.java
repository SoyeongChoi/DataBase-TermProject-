package login;
import java.sql.Timestamp;

public class LogonDataBeanMovie {
	private String mId;
	private String mTitle;
	private String mDirector;
	private String mActor;
	private int mRating;
	private String mDetail;
	private float mBookingRate;
	private String mStartDate;
	private String mEndDate;
	
	public String getmStartDate() {
		return mStartDate;
	}
	public void setmStartDate(String mStartDate) {
		this.mStartDate = mStartDate;
	}
	public String getmEndDate() {
		return mEndDate;
	}
	public void setmEndDate(String mEndDate) {
		this.mEndDate = mEndDate;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}
	public String getmDirector() {
		return mDirector;
	}
	public void setmDirector(String mDirector) {
		this.mDirector = mDirector;
	}
	public String getmActor() {
		return mActor;
	}
	public void setmActor(String mActor) {
		this.mActor = mActor;
	}
	public int getmRating() {
		return mRating;
	}
	public void setmRating(int mRating) {
		this.mRating = mRating;
	}
	public String getmDetail() {
		return mDetail;
	}
	public void setmDetail(String mDetail) {
		this.mDetail = mDetail;
	}
	public float getmBookingRate() {
		return mBookingRate;
	}
	public void setmBookingRate(float nBookingRate) {
		this.mBookingRate = nBookingRate;
	}
	
	}
