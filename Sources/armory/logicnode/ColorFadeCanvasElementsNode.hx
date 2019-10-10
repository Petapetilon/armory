package armory.logicnode;

import iron.Scene;
import armory.trait.internal.CanvasScript;
import iron.math.Vec4;

class ColorFadeCanvasElementsNode extends LogicNode {
	var color1 = new Vec4();
	var color2 = new Vec4();

	var outcolor = new Vec4();

	var fac:Float = 0;
	var oldfac:Float = -1;
	var elementalpha = true;
	var alpha:Int = 0;

	var canvas:CanvasScript;
	var names = new Array<String>();

	public function new(tree:LogicTree){
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready) return;
		color1 = inputs[1].get();
		color2 = inputs[2].get();
		fac = inputs[3].get();
		elementalpha = inputs[4].get();
		alpha = inputs[5].get();
		if (fac < 0) fac = 0;
		if (fac > 1) fac = 1;
		if (alpha < 0) alpha = 0;
		if (alpha > 255) alpha = 255;

		if(oldfac != fac){
				color1.mult(1 - fac);
				color2.mult(fac);
				color1.add(color2);
				outcolor.x = Std.int(color1.x);
				outcolor.y = Std.int(color1.y);
				outcolor.z = Std.int(color1.z);
				outcolor.w = alpha;
			for(i in names){
				if(elementalpha){
					canvas.getElement(i).color = (canvas.getElement(i).color & 0xFF000000) | (calcColor(color1.x, color1.y, color1.z) & 0xFFFFFF);
				}
				else{
					canvas.getElement(i).color = (alpha << 24) | (calcColor(color1.x, color1.y, color1.z) & 0xFFFFFF);
				}
			}
		}

		oldfac = fac;
	}

	override function run(from:Int){
		for(i in 6...inputs.length){
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
		return outcolor != null ? outcolor : null;
	}

	function calcColor(r:Float, g:Float, b:Float):Int{
		return	(Std.int(r) << 16) | (Std.int(g) << 8) | Std.int(b);
	}
}