import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class CanvasSetElementsVisibilityNode(Node, ArmLogicTreeNode):
    '''Canvas set elements visibility Node'''
    bl_idname = 'LNCanvasSetElementsVisibilityNode'
    bl_label = 'Canvas Set Elements Visibility'
    bl_icon = 'QUESTION'
    min_inputs = 2
    min_outputs = 1
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketBool', 'Visibilty')
        self.inputs[-1].default_value = True
        self.outputs.new('ArmNodeSocketAction', 'Out')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -1
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(CanvasSetElementsVisibilityNode, category='Canvas')
