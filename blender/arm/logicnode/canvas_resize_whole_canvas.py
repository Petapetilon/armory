import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class ResizeWholeCanvasNode(Node, ArmLogicTreeNode):
    '''Resize whole canvas node'''
    bl_idname = 'LNResizeWholeCanvasNode'
    bl_label = 'Resize Whole Canvas'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.outputs.new('ArmNodeSocketAction', 'Resized')

add_node(ResizeWholeCanvasNode, category='Canvas')
