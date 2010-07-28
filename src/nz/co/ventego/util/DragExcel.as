package nz.co.ventego.util
{
	import flash.events.MouseEvent;
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragOptions;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import mx.controls.DataGrid;
	import mx.collections.ArrayCollection;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	
	public class DragExcel
	{
		private var _dataGrid:DataGrid;
		private var dateFormatter:DateFormatter;
		private var dragIcon:BitmapData;
		
		public function DragExcel()
		{
			/*var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function ():void
				{
					dragIcon = Bitmap(loader.content).bitmapData;
				}
			);
			loader.load(new URLRequest("/assets/images/icon_excel.png"));*/
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYY-MM-DD-HH-NN-SS";
		} 
		
		public function set dataGrid(dataGrid:DataGrid):void
		{
			_dataGrid = dataGrid;
			_dataGrid.addEventListener(MouseEvent.MOUSE_MOVE, startDragging);
		}
		
		private function startDragging(event:MouseEvent):void
		{
			if (!event.buttonDown) 
			{
				return;
			}

			var options:NativeDragOptions = new NativeDragOptions();
			options.allowCopy = true;
			options.allowLink = true;
			options.allowMove = false;

			var data:Clipboard = new Clipboard();
			data.setData(ClipboardFormats.TEXT_FORMAT,dgToHTML());
			data.setData(ClipboardFormats.FILE_LIST_FORMAT,[createXLS()]);
			NativeDragManager.doDrag(_dataGrid, data, dragIcon, null, options);
		}
		
		private function createXLS():File
		{
			var file:File = File.createTempDirectory().resolvePath("data-"+dateFormatter.format(new Date())+".xls");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(dgToHTML());
			fileStream.close();
			return file;
		}

		private function dgToHTML():String
		{
			var rows:Array = _dataGrid.selectedItems;
			if (!rows || rows.length == 0)
			{
				return "";
			}
			var html:String = "<table>";
			html += "<tr>";
			for (var i:int = 0; i<_dataGrid.columnCount; i++)
			{
				html += "<th>" + DataGridColumn(_dataGrid.columns[i]).headerText + "</th>";							
			}
			html += "</tr>";
			for (var j:int = 0; j<rows.length; j++)
			{
				var row:Object = rows[j];
				html += "<tr>";
				for (var k:int = 0; k<_dataGrid.columnCount; k++)
				{
					html += "<td>" + row[DataGridColumn(_dataGrid.columns[k]).dataField] + "</td>";							
				}
				html += "</tr>";
			}
			html += "</table>";
			return html;
		}
			
	}
}