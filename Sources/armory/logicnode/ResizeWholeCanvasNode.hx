package armory.logicnode;

import iron.Scene;
import zui.Canvas;
import armory.trait.internal.CanvasScript;

class ResizeWholeCanvasNode extends LogicNode {

	var old_width:Float = 0;
	var old_height:Float = 0;
	var width:Float;
	var height:Float;
	var x_ratio:Float;
	var y_ratio:Float;

	var canvas:CanvasScript;

	var force_update:Bool = true;
	var elements = new Array<TElement>();
	var namelock = true;

	public function new(tree:LogicTree) {
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready) return;
		tree.removeUpdate(update);

		elements = canvas.getElements();


		width = kha.System.windowWidth();
		height = kha.System.windowHeight();

		if(old_width == 0 && old_height == 0){
			old_width = width;
			old_height = height;
			return;
		}

		if(force_update){
			old_width = canvas.getWidth();
			old_height = canvas.getHeight();
			force_update = false;
		}

		if(old_width != width || old_height != height || force_update){
			x_ratio = width / old_width;
			y_ratio = height / old_height;

			for (i in elements) rescale(i);
/*
			trace("NEW RESOLUTION");
			trace(width);
			trace(height);
			trace("NEW UI RATIOS");
			trace(x_ratio);
			trace(y_ratio);
			runOutput(0);
*/
		}	

		old_width = width;
		old_height = height;	
		force_update = false;	
	}

	override function run(from:Int) {
		if(from == 1){
			force_update = true;
		}

		canvas = Scene.active.getTrait(CanvasScript);
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
#end

	function rescale(element:TElement){
		var x:Int = cast(element.width * x_ratio);
		var y:Int = cast(element.height * y_ratio);

		element.x *= x_ratio;
		element.y *= y_ratio;
		element.width = x;
		element.height = y;
	}
}