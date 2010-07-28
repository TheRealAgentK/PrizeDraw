package nz.co.ventego.demo.ix.prizeDraw.model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[Table(name="ATTENDEE")]
	public class AttendeeVO
	{
		[Id]
		public var id:int;
		[Column(name="firstName")]
		public var firstName:String;
		[Column(name="lastName")]
		public var lastName:String;
		[Column(name="email")]
		public var email:String;
		[Column(name="winner")]
		public var winner:Boolean;
		[Column(name="prize")]
		public var prize:String;
		
		[ManyToOne(name="meetingId", inverse="true")]
		public var meeting:MeetingVO;	
		
		public function toCSVString():String
		{
			return this.id + "," + this.lastName + "," + this.firstName + "," + this.email + "\n";
		}
	}
}