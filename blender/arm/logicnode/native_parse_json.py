import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class ParseJsonNode(Node, ArmLogicTreeNode):
    '''Parse JSON node'''
    bl_idname = 'LNParseJsonNode'
    bl_label = 'Parse JSON'
    bl_icon = 'CURVE_PATH'
    min_inputs = 3
    min_outputs = 2
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Init (Map Json)')
        self.inputs.new('ArmNodeSocketAction', 'Get Term')
        self.inputs.new('NodeSocketString', 'File')
        self.outputs.new('ArmNodeSocketAction', 'Loaded')
        self.outputs.new('ArmNodeSocketAction', 'Returned')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input_output', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.in_socket_type = 'NodeSocketString'
        op.out_socket_type = 'NodeSocketString'
        op.in_name_format = 'Term {0}'
        op.out_name_format = 'Value {0}'
        op.in_index_name_offset = -2   
        op.out_index_name_offset = -1     
        op2 = row.operator('arm.node_remove_input_output', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(ParseJsonNode, category='Native')
