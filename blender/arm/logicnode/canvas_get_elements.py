import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class GetCanvasElementsNode(Node, ArmLogicTreeNode):
    '''Get canvas elements node'''
    bl_idname = 'LNGetCanvasElementsNode'
    bl_label = 'Get Canvas Elements'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketString', 'File')
        self.outputs.new('ArmNodeSocketAction', 'Loaded')
        self.outputs.new('ArmNodeSocketArray', 'Element Names')

add_node(GetCanvasElementsNode, category='Canvas')
