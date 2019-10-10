import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class SetCanvasPropertiesNode(Node, ArmLogicTreeNode):
    '''Color fade canvas elements Node'''
    bl_idname = 'LNSetCanvasPropertiesNode'
    bl_label = 'Set Canvas Properties'
    bl_icon = 'QUESTION'
    min_inputs = 20
    min_outputs = 0
    
    def __init__(self):
        array_nodes[str(id(self))] = self

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Set')
        self.inputs.new('NodeSocketBool', 'Change Text')
        self.inputs.new('NodeSocketString', 'Text')
        self.inputs.new('NodeSocketBool', 'Change Visibilty')
        self.inputs.new('NodeSocketBool', 'Visibilty')
        self.inputs.new('NodeSocketBool', 'Change Color (includes Alpha)')
        self.inputs.new('NodeSocketVector', 'Color')
        self.inputs.new('NodeSocketBool', 'Change Alpha (overwrite Alpha only)')
        self.inputs.new('NodeSocketInt', 'Alpha')
        self.inputs.new('NodeSocketBool', 'Change X')
        self.inputs.new('NodeSocketInt', 'X')
        self.inputs.new('NodeSocketBool', 'Change Y')
        self.inputs.new('NodeSocketInt', 'Y')
        self.inputs.new('NodeSocketBool', 'Change Width')
        self.inputs.new('NodeSocketInt', 'Width')
        self.inputs.new('NodeSocketBool', 'Change Height')
        self.inputs.new('NodeSocketInt', 'Height')
        self.inputs.new('NodeSocketBool', 'Change Rotation')
        self.inputs.new('NodeSocketFloat', 'Rotation')
        self.inputs.new('ArmNodeSocketArray', 'Elements')

    def draw_buttons(self, context, layout):
        row = layout.row(align=True)
        op = row.operator('arm.node_add_input', text='New', icon='PLUS', emboss=True)
        op.node_index = str(id(self))
        op.socket_type = 'NodeSocketString'
        op.name_format = 'Element {0}'
        op.index_name_offset = -19
        op2 = row.operator('arm.node_remove_input', text='', icon='X', emboss=True)
        op2.node_index = str(id(self))

add_node(SetCanvasPropertiesNode, category='Canvas')
