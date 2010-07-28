package nz.co.ventego.demo.ix.prizeDraw.business
{
	import nz.co.ventego.demo.ix.prizeDraw.model.AttendeeVO;
	import nz.co.ventego.demo.ix.prizeDraw.model.ModelLocator;
	import nz.co.codec.flexorm.EntityManager;
	import nz.co.ventego.util.ArrayCollectionUtils;

	public class AttendeeManager
	{	
		private static var entityManager:EntityManager = EntityManager.instance;
		
		public static function addAttendee(attendee:AttendeeVO):void
		{
			var newID:int = entityManager.save(attendee);
			
			attendee.id = newID;
			ModelLocator.getInstance().attendees.addItem(attendee);
		}
		
		public static function updateAttendee(attendee:AttendeeVO):void
		{
			entityManager.save(attendee);
			ModelLocator.getInstance().attendees.setItemAt(attendee,ArrayCollectionUtils.getItemIndexByProperty(ModelLocator.getInstance().attendees,"id",attendee.id));			
		}
		
		public static function deleteAttendee(attendee:AttendeeVO):void
		{
			entityManager.remove(attendee);
			ModelLocator.getInstance().attendees.removeItemAt(ArrayCollectionUtils.getItemIndexByProperty(ModelLocator.getInstance().attendees,"id",attendee.id)); 	
		}
		
		public static function loadInitialData():void
		{
			ModelLocator.getInstance().attendees = entityManager.findAll(AttendeeVO);
		}
	}
}