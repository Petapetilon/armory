package armory.logicnode;

class CounterNode extends LogicNode {

	var value = 1;
    var count = 0;
    var resetOnMax = false;

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function run(from:Int) {
        
        value = inputs[2].get();
        resetOnMax = inputs[3].get();
		if (from == 0) { // count up
            count++;
            if (count == value) {
                runOutput(1);
                if (resetOnMax)
                    count = 0;
            }
		} else { // reset
            count = 0;
        }
        runOutput(0);
	}

	override function get(from:Int):Dynamic {
		return count;
	}
}
