import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class ColorFadeCanvasElementsNode(Node, ArmLogicTreeNode):
    '''Color fade canvas elements Node'''
    bl_idname = 'LNColorFadeCanvasElementsNode'
    bl_label = 'Color Fade Canvas Elements'
    bl_icon = 'QUESTION'
    min_inputs = 6
    min_outputs = 0
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Init')
        self.inputs.new('NodeSocketVector', 'Color 1')
        self.inputs.new('NodeSocketVector', 'Color 2')
        self.inputs.new('NodeSocketFloat', 'Fac')
        self.inputs.new('NodeSocketBool', 'Use Elements Alpha')
        self.inputs[-1].default_value = True
        self.inputs.new('NodeSocketInt', 'Alpha Overwrite')
        self.outputs.new('NodeSocketVector', 'Element Color')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -5
        op2 = row.operator('arm.node_remove_input', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(ColorFadeCanvasElementsNode, category='Canvas')
