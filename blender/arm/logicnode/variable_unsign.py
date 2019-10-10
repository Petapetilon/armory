import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class UnsignVariableNode(Node, ArmLogicTreeNode):
    '''Unsign Variable node'''
    bl_idname = 'LNUnsignVariableNode'
    bl_label = 'Unsign Variable'
    bl_icon = 'CURVE_PATH'
    
    def init(self, context):
        self.inputs.new('NodeSocketShader', 'Variable')
        self.outputs.new('NodeSocketShader', 'Output')

add_node(UnsignVariableNode, category='Variable')
