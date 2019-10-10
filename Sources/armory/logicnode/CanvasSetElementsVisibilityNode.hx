package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;

class CanvasSetElementsVisibilityNode extends LogicNode {

	var init:Bool = true;
	var vis:Bool;

	var canvas:CanvasScript;
	var names = new Array<String>();

	public function new(tree:LogicTree) {
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready) return;
		for(i in names){
			if(canvas.getElement(names[0]) == null) return;
		}
		tree.removeUpdate(update);

		for(i in names){
			trace(i);
			canvas.getElement(i).visible = vis;
		}
		runOutput(0);
	}

	override function run(from:Int) {
		if(init){
			for(i in 2...inputs.length){
				names.push(inputs[i].get());
			}

			vis = inputs[1].get();
			init = false;
		}

		canvas = Scene.active.getTrait(CanvasScript);
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
#end
}