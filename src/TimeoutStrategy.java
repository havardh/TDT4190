

class TimeoutStrategy implements DeadlockStrategy {

	private ServerImpl server;
	private long timeout;

	private boolean notified = false;

	public TimeoutStrategy(ServerImpl server, long timeout) {
		this.server = server;
		this.timeout = timeout;
	}

	public void onLock() {
		this.notified = false;

		TimeoutStrategy ts = this;
		new Thread() {

			public void run() {
				wait(timeout);
				if (!ts.notified) {
					server.abortTransaction();
				}
			}

		}.start();
	}

	public void onNotify() {
		this.notified = true;
	}

}
