package nz.co.ventego.demo.ix.prizeDraw.model
{
	import mx.collections.ArrayCollection;

	public class ModelLocator
	{
		[Bindable]
		public var meetings:ArrayCollection;
		[Bindable]
		public var attendees:ArrayCollection;
		
		static private var _instance:ModelLocator;
			
		public function ModelLocator(modelLocatorEnforcer:ModelLocatorEnforcer) 
		{
			meetings = new ArrayCollection();
			attendees = new ArrayCollection();
		}
								   
		public static function getInstance():ModelLocator
		{
			if (ModelLocator._instance == null)
			{
				ModelLocator._instance = new ModelLocator(new ModelLocatorEnforcer());
			}

			return ModelLocator._instance;
		}
	}
}

class ModelLocatorEnforcer {}