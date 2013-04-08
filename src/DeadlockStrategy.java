public interface DeadlockStrategy {


	public void onLock();

	public void onNotify();

}
