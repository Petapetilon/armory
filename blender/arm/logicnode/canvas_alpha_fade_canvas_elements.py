import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class AlphaFadeCanvasElementsNode(Node, ArmLogicTreeNode):
    '''Alpha fade canvas elements Node'''
    bl_idname = 'LNAlphaFadeCanvasElementsNode'
    bl_label = 'Alpha Fade Canvas Elements'
    bl_icon = 'QUESTION'
    min_inputs = 5
    min_outputs = 1
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Init')
        self.inputs.new('NodeSocketInt', 'Alpha 1')
        self.inputs.new('NodeSocketInt', 'Alpha 2')
        self.inputs.new('NodeSocketFloat', 'Fac')
        self.inputs.new('NodeSocketBool', 'Clamp Max Alpha per Element')
        self.outputs.new('NodeSocketInt', 'Element Alpha')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -4
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(AlphaFadeCanvasElementsNode, category='Canvas')
