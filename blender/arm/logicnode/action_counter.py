import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class CounterNode(Node, ArmLogicTreeNode):
    '''Counter node'''
    bl_idname = 'LNCounterNode'
    bl_label = 'Counter'
    bl_icon = 'CURVE_PATH'
    
    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('ArmNodeSocketAction', 'Reset')
        self.inputs.new('NodeSocketInt', 'Value')
        self.inputs[-1].default_value = 1
        self.inputs.new('NodeSocketBool', 'Self Reset')
        self.inputs[-1].default_value = False

        self.outputs.new('ArmNodeSocketAction', 'Out')
        self.outputs.new('ArmNodeSocketAction', 'Finished')
        self.outputs.new('NodeSocketInt', 'Count')

add_node(CounterNode, category='Action')
