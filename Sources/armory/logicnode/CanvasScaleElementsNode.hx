package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;

class CanvasScaleElementsNode extends LogicNode {

	var init:Bool = true;
	var start_pos_x = new Array<Float>();
	var start_pos_y = new Array<Float>();
	var start_width = new Array<Float>();
	var start_height = new Array<Float>();
	var x_min:Float = 2147483647;
	var x_max:Float = 0;
	var y_min:Float = 2147483647;
	var y_max:Float = 0;
	var x_scalepos:Float;
	var y_scalepos:Float;

	var scale_x:Float = 0;
	var scale_y:Float = 0;
	var fac:Float = 0;

	var canvas:CanvasScript;
	var names = new Array<String>();

	public function new(tree:LogicTree) {
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready) return;
		for(i in names){
			if(canvas.getElement(i).id == null) return;
		}
		tree.removeUpdate(update);
	
		if(init){
			for(i in 6...inputs.length){
				names.push(inputs[i].get());
			}
			
			for(i in 0...names.length){
				start_pos_x.push(canvas.getElement(names[i]).x);
				start_pos_y.push(canvas.getElement(names[i]).y);
				start_width.push(canvas.getElement(names[i]).width);
				start_height.push(canvas.getElement(names[i]).height);
			}

			if(inputs[3].get()){
				getBoundingBox();
			}
				
			init = false;
		}

		scale_x = inputs[1].get();
		scale_y = inputs[2].get();
		if(!inputs[3].get()){
				x_scalepos = inputs[4].get();
				y_scalepos = inputs[5].get();
		}

		trace(x_scalepos + ", " + y_scalepos);

		for(i in 0...names.length){
			canvas.getElement(names[i]).x = x_scalepos + scale_x * (start_pos_x[i] - x_scalepos);
			canvas.getElement(names[i]).y = y_scalepos + scale_y * (start_pos_y[i] - y_scalepos);
			canvas.getElement(names[i]).width = cast(start_width[i] * scale_x);
			canvas.getElement(names[i]).height = cast(start_height[i] * scale_y);
		}

		runOutput(0);
	}

	override function run(from:Int) {
		canvas = Scene.active.getTrait(CanvasScript);
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
#end

	function getBoundingBox(){
		for (i in names){
			if(canvas.getElement(i).x < x_min){
				x_min = canvas.getElement(i).x;
			}

			if(canvas.getElement(i).x + canvas.getElement(i).width > x_max){
				x_max = canvas.getElement(i).x + canvas.getElement(i).width;
			}

			if(canvas.getElement(i).y < y_min){
				y_min = canvas.getElement(i).y;
			}

			if(canvas.getElement(i).y + canvas.getElement(i).height > y_max){
				y_max = canvas.getElement(i).y + canvas.getElement(i).height;
			}
		}

		trace(x_min + ", " + x_max + "; " + y_min + ", " + y_max);

		x_scalepos = (x_max + x_min) / 2;
		y_scalepos = (y_max + y_min) / 2;
	}
}