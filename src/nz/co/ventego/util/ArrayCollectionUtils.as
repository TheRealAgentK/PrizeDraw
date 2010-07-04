package nz.co.ventego.util
{
	import mx.collections.ArrayCollection;
	
	public class ArrayCollectionUtils
	{
		static public function getItemIndexByProperty(arrayCollection:ArrayCollection, property:String, value:*):int
		{
			for (var i:int = 0; i < arrayCollection.length; i++)
			{
				var obj:Object = Object(arrayCollection[i])
				
				if (obj[property] == value)
				{
					return i;
				}
			}
			
			return -1;
		}
	}
}