package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;

class CanvasDislocateElementsNode extends LogicNode {

	var init:Bool = true;
	var start_pos_x = new Array<Float>();
	var start_pos_y = new Array<Float>();
	var dislocation_x:Float = 0;
	var dislocation_y:Float = 0;
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
			for(i in 4...inputs.length){
				names.push(inputs[i].get());
			}
			
			for(i in 0...names.length){
				start_pos_x.push(canvas.getElement(names[i]).x);
				start_pos_y.push(canvas.getElement(names[i]).y);
			}
				
			init = false;
		}

		dislocation_x = inputs[1].get();
		dislocation_y = inputs[2].get();	
		fac = inputs[3].get();

		trace(dislocation_x + ", " + dislocation_y + ", " + fac);

		for(i in 0...names.length){
			canvas.getElement(names[i]).x = start_pos_x[i] + fac * dislocation_x;
			canvas.getElement(names[i]).y = start_pos_y[i] + fac * dislocation_y;
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
}