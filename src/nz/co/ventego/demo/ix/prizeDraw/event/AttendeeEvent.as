package nz.co.ventego.demo.ix.prizeDraw.event
{
	import mx.events.FlexEvent;
	
	import nz.co.ventego.demo.ix.prizeDraw.model.AttendeeVO;
	
	public class AttendeeEvent extends FlexEvent
	{
		public static const CREATE:String = "createAttendee";
		public static const UPDATE:String = "updateAttendee";
		public static const DELETE:String = "deleteAttendee";
		public static const DRAW:String = "drawAttendee";
		
		public var attendee:AttendeeVO
		
		public function AttendeeEvent(type:String, attendee:AttendeeVO)
		{
			super(type);
			this.attendee = attendee;
		}
	}
}