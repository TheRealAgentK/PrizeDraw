package nz.co.ventego.demo.ix.prizeDraw.event
{
	import mx.events.FlexEvent;
	
	import nz.co.ventego.demo.ix.prizeDraw.model.MeetingVO;
	
	public class MeetingEvent extends FlexEvent
	{
		public static const CREATE:String = "createMeeting";
		public static const UPDATE:String = "updateMeeting";
		public static const DELETE:String = "deleteMeeting";
		public static const EXPORT:String = "exportMeetingData";
		public static const EXPORT_NATIVE:String = "exportMeetingDataNative";
		
		public var meeting:MeetingVO;
		public var exportFileName:String;
		
		public function MeetingEvent(type:String, meeting:MeetingVO, exportFileName:String = "")
		{
			super(type);
			this.meeting = meeting;
			this.exportFileName = exportFileName;
		}
	}
}