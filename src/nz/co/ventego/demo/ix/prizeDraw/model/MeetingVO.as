package nz.co.ventego.demo.ix.prizeDraw.model
{
 	import mx.collections.ArrayCollection;
 	import mx.collections.IList;
	
	[Bindable]
	[Table(name="MEETING")]
	public class MeetingVO
	{
		private var _attendees:IList;
		
		[Id]
		public var id:int;
		[Column(name="title")]
		public var title:String;
		[Column(name="date")]
		public var date:Date;
		
		[OneToMany(type="nz.co.ventego.demo.ix.prizeDraw.model.AttendeeVO", fkColumn="meetingId", lazy="false", cascade="all")]
		public function set attendees(value:IList):void
		{
			_attendees = value;
			for each(var attendee:AttendeeVO in value)
			{
				attendee.meeting = this;
			}
		}
		
		public function get attendees():IList
		{
			return _attendees;
		}
		
		public function toHMTLList():String
		{
			var htmlTable:String = "<p>Meeting:" + this.title + "</p>" + "<p>Date:" + this.date.toString() + "</p>";
				
			for (var i:int = 0; i < attendees.length; i++)
			{
				var attendee:AttendeeVO = attendees.getItemAt(i) as AttendeeVO;
				
				htmlTable = htmlTable + "<li>" + attendee.firstName + " " + attendee.lastName + "(Attendee ID: " + attendee.id + ", Email: " + attendee.email +")</li>";
			}
			
			htmlTable = htmlTable + "</table>";
			
			return htmlTable;	
		}
		
	}
}