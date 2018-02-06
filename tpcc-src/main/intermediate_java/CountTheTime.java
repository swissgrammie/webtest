

public class CountTheTime implements AutoCloseable {
	private long _start;
	private long _end;
	private String _method;
	public  CountTheTime (String method) {
		_start = System.currentTimeMillis();
		_method = method;
	}
	
	public void close() {
		long end = System.currentTimeMillis();
		System.out.println(_method + ":" + (end-_start));
	}
	
}





