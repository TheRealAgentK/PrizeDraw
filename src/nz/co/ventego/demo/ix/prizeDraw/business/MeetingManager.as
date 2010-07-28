package nz.co.ventego.demo.ix.prizeDraw.business
{
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	
	import nz.co.codec.flexorm.EntityManager;
	import nz.co.ventego.demo.ix.prizeDraw.model.AttendeeVO;
	import nz.co.ventego.demo.ix.prizeDraw.model.MeetingVO;
	import nz.co.ventego.demo.ix.prizeDraw.model.ModelLocator;
	import nz.co.ventego.util.ArrayCollectionUtils;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	

	public class MeetingManager
	{	
		private static var model:ModelLocator = ModelLocator.getInstance();
		private static var entityManager:EntityManager = EntityManager.instance;
		
		
		public static function addMeeting(meeting:MeetingVO):void
		{
			var newID:int = entityManager.save(meeting);
			
			meeting.id = newID;
			model.meetings.addItem(meeting);
		}
		
		public static function updateMeeting(meeting:MeetingVO):void
		{
			entityManager.save(meeting);
			model.meetings.setItemAt(meeting,ArrayCollectionUtils.getItemIndexByProperty(model.meetings,"id",meeting.id));
			
		}
		
		public static function deleteMeeting(meeting:MeetingVO):void
		{
			entityManager.remove(meeting);
			model.meetings.removeItemAt(ArrayCollectionUtils.getItemIndexByProperty(model.meetings,"id",meeting.id));
			model.attendees = entityManager.findAll(AttendeeVO);	
		}
		
		public static function exportMeetingData(meeting:MeetingVO,exportFileName:String):void
		{
			var exportString:String = "";
			var attendees:ArrayCollection = entityManager.load(MeetingVO,meeting.id).attendees;
			
			for (var i:int=0; i<attendees.length; i++)
			{
				exportString = exportString + (attendees.getItemAt(i) as AttendeeVO).toCSVString();		
			}	
			
			var file:File = new File("app-storage:/" + exportFileName);
			var stream:FileStream = new FileStream();
			stream.open(file,FileMode.WRITE);
			stream.writeUTFBytes(exportString);
			stream.close();
		}
		
		public static function loadInitialData():void
		{
			model.meetings = entityManager.findAll(MeetingVO);
		}
	}
}