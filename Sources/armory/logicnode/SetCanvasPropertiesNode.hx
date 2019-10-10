package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;
import iron.math.Vec4;

class SetCanvasPropertiesNode extends LogicNode {
	var names = new Array<String>();
	var canvas:CanvasScript;

	public function new(tree:LogicTree) {
		super(tree);
	}

	function update() {
		if (!canvas.ready) return;
		tree.removeUpdate(update);
		
		if(inputs[19].get() != null){
			names = inputs[19].get();
		}

		for(i in 20...inputs.length){
			names.push(inputs[i].get());
		}

		if(inputs[1].get()){
			var text = inputs[2].get();
			for(i in names){
				canvas.getElement(i).text = text;
			}
		}	

		if(inputs[3].get()){
			var vis = inputs[4].get();
			for(i in names){
				canvas.getElement(i).visible = vis;
			}
		}

		if(inputs[5].get()){
			var col = inputs[6].get();
			if(col.x < 0) 	col.x = 0;
			if(col.x > 255) col.x = 255;
			if(col.y < 0) 	col.y = 0;
			if(col.y > 255) col.y = 255;
			if(col.z < 0) 	col.z = 0;
			if(col.z > 255) col.z = 255;
			if(col.w < 0) 	col.w = 0;
			if(col.w > 255) col.w = 255;
			var color:Int = (Std.int(col.w) << 24) | (Std.int(col.x) << 16) | (Std.int(col.y) << 8) | Std.int(col.w);
			for(i in names){
				canvas.getElement(i).color = color;
			}

			//trace(color);
		}

		if(inputs[7].get()){
			var a = inputs[8].get();
			if(a < 0) a = 0;
			if(a > 255) a = 255;
			for(i in names){
				canvas.getElement(i).color = (canvas.getElement(i).color & 0xFFFFFF) | (a << 24);
			}

			//trace(a);
		}

		if(inputs[9].get()){
			var x = inputs[10].get();
			for(i in names){
				canvas.getElement(i).x = x;
			}
		}

		if(inputs[11].get()){
			var y = inputs[12].get();
			for(i in names){
				canvas.getElement(i).y = y;
			}
		}

		if(inputs[13].get()){
			var w = inputs[14].get();
			for(i in names){
				canvas.getElement(i).width = Std.int(w);
			}
		}

		if(inputs[15].get()){
			var h = inputs[16].get();
			for(i in names){
				canvas.getElement(i).height = Std.int(h);
			}
		}

		if(inputs[17].get()){
			var r = inputs[18].get();
			for(i in names){
				canvas.getElement(i).rotation = r;
			}
		}		
	}

	override function run(from:Int){
		canvas = Scene.active.getTrait(CanvasScript);
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
}
