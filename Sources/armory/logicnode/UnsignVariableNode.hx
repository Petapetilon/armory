package armory.logicnode;

class UnsignVariableNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function get(from:Int):Dynamic {
		var data = inputs[0].get();
		if (data < 0) return data * -1;
		else return data;
	}
}
