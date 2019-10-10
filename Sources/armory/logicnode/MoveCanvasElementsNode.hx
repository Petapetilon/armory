package armory.logicnode;

import armory.trait.internal.CanvasScript;
import iron.math.Vec4;
import iron.object.CameraObject;
import iron.Scene;
import iron.Scene;
import kha.System;
import zui.Canvas;

class MoveCanvasElementsNode extends LogicNode {
	var init:Bool = true;
	var done:Bool = false;

	var canvas:CanvasScript;
	var names = new Array<String>();

	var xs = new Array<Float>();
	var ys = new Array<Float>();
	var side:Int = 0;
	var dir:Int = 0;

	var cam:Dynamic;
	var screen_centre = new Vec4();
	var screen_space = new Vec4();


	public function new(tree:LogicTree) {
		super(tree);
	}

#if arm_ui
	function update() {
		if (!canvas.ready || cam == null) return;
		if(init){
			if(screen_centre.x == null || screen_centre.y == null || screen_centre.z == null) return;
			if(!inputs[1].get()){
				for(i in 3...inputs.length){
					names.push(inputs[i].get());
				}
			}
			else{
				var temp = canvas.getElements();
				for(i in temp){
					names.push(i.name);
				}
			}
			
			screen_centre = inputs[2].get();		
			getInitValues();
			init = false;
		}

		tree.removeUpdate(update);
		panPanel();
	}

	override function run(from:Int) {		
		canvas = Scene.active.getTrait(CanvasScript);
		cam = Scene.active.camera;
		if (canvas == null) canvas = Scene.active.camera.getTrait(CanvasScript);

		// Ensure canvas is ready
		tree.notifyOnUpdate(update);
		update();
	}
#end

	inline function panPanel(){
		screen_space.setFrom(screen_centre);
		screen_space.applyproj(cam.V);
		screen_space.applyproj(cam.P);
									
		moveParts(	kha.System.windowWidth() * 0.5 - 
					(kha.System.windowWidth() * 0.5 - 
					screen_space.x * kha.System.windowWidth() * 0.5),
					kha.System.windowHeight() * 0.5 - 
					(kha.System.windowHeight() * 0.5 + 
					screen_space.y * kha.System.windowHeight() * 0.5));
	}

	inline function moveParts(posx:Float, posy:Float){
		for(i in 0...names.length){
			canvas.getElement(names[i]).x = xs[i] + posx;
			canvas.getElement(names[i]).y = ys[i] + posy;
		}
	}

	inline function getInitValues(){
		for(i in names){
			xs.push(canvas.getElement(i).x);
			ys.push(canvas.getElement(i).y);
		}		
	}
}