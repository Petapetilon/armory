package armory.logicnode;

class GetCanvasElementsNode extends LogicNode {

	var data:Dynamic;
	var names = new Array<String>();
	var initialized:Bool = false;

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function run(from:Int) {

		var file:String = inputs[1].get();				
		iron.data.Data.getBlob(file, function(b:kha.Blob) {
			data = haxe.Json.parse(b.toString());

			for(i in 0... data.elements.length){
				names.push(data.elements[i].name);
			}

			initialized = true;
			runOutput(0);
		});	
	}

	override function get(from:Int):Dynamic {
		if(initialized){
			if(names.length == null) return null;
			if(from == 1) return names;
			if(from == 2) return names.length;
		}	
		return null;
	}
}
