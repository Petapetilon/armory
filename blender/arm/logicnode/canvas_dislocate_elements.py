import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class CanvasDislocateElementsNode(Node, ArmLogicTreeNode):
    '''Canvas dislocate elements Node'''
    bl_idname = 'LNCanvasDislocateElementsNode'
    bl_label = 'Canvas Dislocate Elements'
    bl_icon = 'QUESTION'
    min_inputs = 4
    min_outputs = 1
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Update')
        self.inputs.new('NodeSocketFloat', 'Dislocation X')
        self.inputs[-1].default_value = 0
        self.inputs.new('NodeSocketFloat', 'Dislocation Y')
        self.inputs[-1].default_value = 0
        self.inputs.new('NodeSocketFloat', 'Fac')
        self.inputs[-1].default_value = 0
        self.outputs.new('ArmNodeSocketAction', 'Out')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -3
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(CanvasDislocateElementsNode, category='Canvas')
