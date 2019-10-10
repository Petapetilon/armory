import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class CanvasScaleElementsNode(Node, ArmLogicTreeNode):
    '''Canvas scale elements Node'''
    bl_idname = 'LNCanvasScaleElementsNode'
    bl_label = 'Canvas Scale Elements'
    bl_icon = 'QUESTION'
    min_inputs = 6
    min_outputs = 1
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Update')
        self.inputs.new('NodeSocketFloat', 'Scale X')
        self.inputs[-1].default_value = 1
        self.inputs.new('NodeSocketFloat', 'Scale Y')
        self.inputs[-1].default_value = 1
        self.inputs.new('NodeSocketBool', 'Scale relative to Bounding Box Center')
        self.inputs[-1].default_value = True
        self.inputs.new('NodeSocketFloat', 'Scale Center X')
        self.inputs[-1].default_value = 0
        self.inputs.new('NodeSocketFloat', 'Scale Center Y')
        self.inputs[-1].default_value = 0
        self.outputs.new('ArmNodeSocketAction', 'Out')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -5
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(CanvasScaleElementsNode, category='Canvas')
