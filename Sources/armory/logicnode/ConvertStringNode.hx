package armory.logicnode;

class ConvertStringNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function get(from:Int):Dynamic{
		var temp = inputs[0].get() != null ? inputs[0].get() : return null;
		if(from == 0){
			if(getType(temp) == 1)	return convertInt(temp);
		}
		else if(from == 1){
			if(getType(temp) == 2)	return convertFloat(temp);
		}
		else{
			if(getType(temp) == 3)	return convertBool(temp);
		}
			return null;
	}

	inline function getType(s:String):Int{
		var isBool:Bool = false;
		var isFloat:Bool = false;
		for(i in 0...s.length){
			switch(s.charAt(i)){
				case '.':
				if(!isFloat){
					isFloat = true;
				}
				else{
					return 0;
				}

				case '0':	continue;
				case '1':	continue;
				case '2':	continue;
				case '3':	continue;
				case '4':	continue;
				case '5':	continue;
				case '6':	continue;
				case '7':	continue;
				case '8':	continue;
				case '9':	continue;
				case '0':	continue;

				case 't':
				isBool = true;	
				break;

				case 'f':
				isBool = true;
				break;

				default:	return 0;
			}
		}

		if(isFloat){
			return 2;
		}

		if(isBool){
			return 3;
		}

		return 1;
	}

	inline function convertInt(s:String):Int{
		var out:Int = 0;
		for (i in 0...s.length){
			if(out == 0){
				out = cast(s.charAt(i));
			}
			else{
				out += cast(s.charAt(i));
			}
		}

		return out;
	}

	inline function convertFloat(s:String):Float{
		var out:Float = 0;
		var dotpos:Int = 0;
		var dot:Bool = false;
		for(i in 0...s.length){
			if(s.charAt(i) == '.'){
				dot = true;
			}
			else{
				if(out == 0){
					out = cast(s.charAt(i));
				}
				else{
					out += cast(s.charAt(i));
				}
			}
			
			if(dot){
				dotpos++;
			}
		}

		for(i in 1...dotpos){
			out *= 0.1;
		}

		return out;
	}

	inline function convertBool(s:String):Bool{
		if(s.charAt(0) == 't') 	return true;
		if(s.charAt(0) == 'f') 	return false;
		return null;
	}
}