import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class MoveCanvasElementsNode(Node, ArmLogicTreeNode):
    '''Move canvas elements Node'''
    bl_idname = 'LNMoveCanvasElementsNode'
    bl_label = 'Move Canvas Elements'
    bl_icon = 'QUESTION'
    min_inputs = 3
    min_outputs = 0
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Update')
        self.inputs.new('NodeSocketBool', 'Move Whole')
        self.inputs[-1].default_value = True
        self.inputs.new('NodeSocketVector', 'Relative Point')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -2
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(MoveCanvasElementsNode, category='Canvas')
