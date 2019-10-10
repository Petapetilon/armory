package armory.logicnode;

class ParseJsonNode extends LogicNode {

	var data:String;
	var searchterm = new Array<String>();
	var parsing:Bool = false;
	var map = new Map();

	var templength:Int = 0;

	public function new(tree:LogicTree) {
		super(tree);
	}

	override function run(from:Int) {		
		if(from == 0){
			var file:String = inputs[2].get();
			iron.data.Data.getBlob(file, function(b:kha.Blob) {
				data = b.toString();
			});

			getObject("", 0);		
			for(i in 3...inputs.length){
				searchterm.push(null);
			}

			runOutput(0);
		}	
		else{
			for(i in 3...inputs.length){			
				searchterm[i - 3] = inputs[i].get();
				if(searchterm[i - 3] == "") return;
			}

			runOutput(1);
		}	

		//trace(searchterm);
	}

	override function get(from:Int):Dynamic{
		if(searchterm[from - 2] == "" || searchterm[from - 2] == null) return null;
		map.get(searchterm[from - 2]) == null ? return null : return map.get(searchterm[from - 2]);
	}

	inline function getObject(tempkey:String, datapos:Int):Int{
		var tempname:String = "";
		var tempvalue:String = "";
		var getvalue:Bool = false;
		var i:Int = datapos;
		while(i < data.length){
			switch(data.charAt(i)){
				case '{' :
				i = getObject(tempkey + tempname, i + 1);

				case '[' :
				i = getArray(tempkey + tempname, i + 1);

				case '"' :
				if(getvalue){
					tempvalue = getString(i + 1);
					//i += tempvalue.length + 1;
					i = templength;
					templength = 0;
				}
				else{
					if(tempkey != ""){
						tempname = "." + getString(i + 1);
						//i += tempname.length;
						i = templength;
						templength = 0;
					}
					else{
						tempname =  getString(i + 1);
						//i += tempname.length + 1;
						i = templength;
						templength = 0;
					}	
				}

				case '0':
				tempvalue = tempvalue + "0";
				getvalue = false;
				case '1':
				tempvalue = tempvalue + "1";
				getvalue = false;
				case '2':
				tempvalue = tempvalue + "2";
				getvalue = false;
				case '3':
				tempvalue = tempvalue + "3";
				getvalue = false;
				case '4':
				tempvalue = tempvalue + "4";
				getvalue = false;
				case '5':
				tempvalue = tempvalue + "5";
				getvalue = false;
				case '6':
				tempvalue = tempvalue + "6";
				getvalue = false;
				case '7':
				tempvalue = tempvalue + "7";
				getvalue = false;
				case '8':
				tempvalue = tempvalue + "8";
				getvalue = false;
				case '9':
				tempvalue = tempvalue + "9";
				getvalue = false;
				case '.':
				tempvalue = tempvalue + ".";
				getvalue = false;
				case ':' :
				getvalue = true;

				case 't':
				tempvalue = "true";
				i += 3;
				continue;

				case 'f':
				tempvalue = "false";
				i += 4;
				continue;

				case ',' :
				getvalue = false;
				if(tempname != "" && tempvalue != ""){
					//trace(tempkey + tempname + " => " + tempvalue);
					map.set(tempkey + tempname, tempvalue);
				} 

				tempname = "";
				tempvalue = "";

				case ' ' :
				i++;
				continue;

				case '}' :
				if(tempname != "" && tempvalue != ""){
					//trace(tempkey + tempname + " => " + tempvalue);
					map.set(tempkey + tempname, tempvalue);
				} 

				return i ;
			}

			i++;
		}

		return null;
	}

	inline function getArray(tempkey:String, datapos:Int):Int{
		var tempvalue:String = "";
		var iterator = 0;
		var i:Int = datapos;
		while(i < data.length){
			switch(data.charAt(i)){
				case '{' :
				i = getObject(tempkey + "[" + iterator + "]", i + 1);
				iterator++;

				case '[' :
				i = getArray(tempkey + "[" + iterator + "]", i + 1);
				iterator++;

				case '"' :
				tempvalue = getString(i + 1);
				//i += tempvalue.length + 1;	
				i = templength;
				templength = 0;

				case '0':
				tempvalue = tempvalue + "0";
				case '1':
				tempvalue = tempvalue + "1";
				case '2':
				tempvalue = tempvalue + "2";
				case '3':
				tempvalue = tempvalue + "3";
				case '4':
				tempvalue = tempvalue + "4";
				case '5':
				tempvalue = tempvalue + "5";
				case '6':
				tempvalue = tempvalue + "6";
				case '7':
				tempvalue = tempvalue + "7";
				case '8':
				tempvalue = tempvalue + "8";
				case '9':
				tempvalue = tempvalue + "9";
				case '.':
				tempvalue = tempvalue + ".";

				case 't':
				tempvalue = "true";
				i += 3;
				continue;

				case 'f':
				tempvalue = "false";
				i += 4;
				continue;

				case ' ' :
				i++;
				continue;

				case "" :
				i++;
				continue;

				case ',' :
				if(tempvalue != ""){
					//trace(tempkey + "[" + iterator + "]" + " => " + tempvalue);
					map.set(tempkey + "[" + iterator + "]", tempvalue);
					tempvalue = "";
					iterator++;
				}
				
				i++;
				continue;

				case ']' :
				if(tempvalue != ""){
					//trace(tempkey + "[" + iterator + "]" + " => " + tempvalue);
					map.set(tempkey + "[" + iterator + "]", tempvalue);
				}
				
				return i;
			}

			i++;
		}
		return null;
	}

	inline function getString(i:Int):String{
		var out:String = "";
		var temp:String = "";

		while(data.charAt(i) != '"'){
			if(data.charAt(i) == '\\'){
				temp = data.charAt(++i);
				i++;
				out = out + temp;
				continue;
			}

			temp = data.charAt(i++);
			out = out + temp;
		}
		
		templength = i;

		return out;
	}
}
