package armory.logicnode;

class SwitchVariableNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function get(from:Int) {
		inputs[2].get() ? return inputs[1].get() : return inputs[0].get();
	}
}
