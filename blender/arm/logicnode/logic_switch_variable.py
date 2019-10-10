import bpy                                                          
from bpy.props import *                                             
from bpy.types import Node, NodeSocket                              
from arm.logicnode.arm_nodes import *                               

class SwitchVariableNode(Node, ArmLogicTreeNode):                   
    '''Switch Variable node'''                                      
    bl_idname = 'LNSwitchVariableNode'                              
    bl_label = 'Switch Variable'                                    
    bl_icon = 'CURVE_PATH'                                          
    
    def init(self, context):                                        
        self.inputs.new('NodeSocketShader', 'Variable if false')    
        self.inputs.new('NodeSocketShader', 'Varibale if true')     
        self.inputs.new('NodeSocketBool', 'Switch')                 
        self.outputs.new("NodeSocketShader", 'Output')              

add_node(SwitchVariableNode, category='Logic')                      
