package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;

class AlphaFadeCanvasElementsNode extends LogicNode {
	var alpha1:Int = 0;
	var alpha2:Int = 0;

	var outalpha:Int;

	var fac:Float = 0;
	var oldfac:Float = -1;
	var clamp:Bool = false;

	var canvas:CanvasScript;
	var names = new Array<String>();

	public function new(tree:LogicTree){
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready) return;
		alpha1 = inputs[1].get();
		alpha2 = inputs[2].get();
		fac = inputs[3].get();
		clamp = inputs[4].get();
		if(alpha1 < 0) alpha1 = 0;
		if(alpha1 > 255) alpha1 = 255;
		if(alpha2 < 0) alpha2 = 0;
		if(alpha2 > 255) alpha2 = 255;
		if (fac < 0) fac = 0;
		if (fac > 1) fac = 1;
		if(oldfac != fac){
				alpha1 = Std.int(alpha1 * (1 - fac) + alpha2 * fac);
				if(alpha1 > 255) alpha1 = 255;
				outalpha = alpha1;					
			for(i in names){
				if(clamp){
					if(alpha1 < (canvas.getElement(i).color >>> 24)){
						canvas.getElement(i).color = (canvas.getElement(i).color & 0xFFFFFF) | (alpha1 << 24);			
					}
				}	
				else{
					canvas.getElement(i).color = (canvas.getElement(i).color & 0xFFFFFF) | (alpha1 << 24);	
				}	
			}
		}

		oldfac = fac;
	}

	override function run(from:Int){
		for(i in 5...inputs.length){
			names.push(inputs[i].get());
		}

		canvas = Scene.active.getTrait(CanvasScript);
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
#end
	override function get(from:Int):Dynamic{
		return outalpha != null ? outalpha : null;
	}
}
