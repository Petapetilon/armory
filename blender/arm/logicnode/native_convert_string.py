import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class ConvertStringNode(Node, ArmLogicTreeNode):
    '''Convert string node'''
    bl_idname = 'LNConvertStringNode'
    bl_label = 'Convert String'
    bl_icon = 'CURVE_PATH'
  
    def init(self, context):
        self.inputs.new('NodeSocketString', 'Value')
        self.outputs.new('NodeSocketInt', 'Int')
        self.outputs.new('NodeSocketFloat', 'Float')
        self.outputs.new('NodeSocketBool', 'Bool')

add_node(ConvertStringNode, category='Native')
