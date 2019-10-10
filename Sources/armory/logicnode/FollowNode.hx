package armory.logicnode;

import iron.math.Vec4;
import iron.math.Quat;
import iron.object.Object;

class FollowNode extends LogicNode {

	var target = new Vec4();
	var follow = new Vec4();
	var direction = new Vec4();
	var movement = new Vec4();
	var dist:Float;
	//var followobj = new Object();
	var mindist:Float;
	var maxdist:Float;
	var maxacc:Float;
	var maxspeed:Float;
	var dec:Float;

	var accelerated:Bool = false;
	var init:Bool = true;

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function run(from:Int){
		inputs[1].get() != null ? target = inputs[1].get() : return;
		inputs[2].get() != null ? follow = inputs[2].get().transform.loc : return;
		if(init){
			movement = inputs[3].get();
		}
		init = false;
		mindist = inputs[4].get();
		maxdist = inputs[5].get();
		maxacc = inputs[6].get();
		dec = inputs[7].get();
		maxspeed = inputs[8].get();

		direction = direction.subvecs(target, follow);
		direction.normalize();

		dist = Vec4.distance(target, follow);
		if(dist > maxdist){
			movement.add(direction.mult(dist - maxdist < maxacc ? dist - maxdist : maxacc));
			accelerated = true;
		}
		else{
			if(dist > mindist && accelerated){
				movement.sub(direction.mult((dist - mindist > 0 ? dist - mindist : 1) * dec));
				if(dist - mindist < 0 || movement.length() < 2 * dec){
					accelerated = false;
				}
				trace(dist - mindist);
			}
			else{
				movement.sub(movement);
				accelerated = false;
				if(inputs[9].get()){
					runOutput(0);
				}
			}
		}

//		movement.normalize();
		movement.clamp(0, maxspeed);

		//trace(movement.length());

//		trace(direction);
//		trace(movement);

		inputs[2].get().transform.loc.add(movement);
		inputs[2].get().transform.buildMatrix();

		if(dist < mindist && !accelerated){
			runOutput(0);
		}
	}

	override function get(from:Int):Dynamic{
		return movement;
	}
}
