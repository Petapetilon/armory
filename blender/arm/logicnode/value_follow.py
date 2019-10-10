import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class FollowNode(Node, ArmLogicTreeNode):
    '''Look at node'''
    bl_idname = 'LNFollowNode'
    bl_label = 'Follow'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'Update')
        self.inputs.new('NodeSocketVector', 'Target')
        self.inputs.new('ArmNodeSocketObject', 'Follower')
        self.inputs.new('NodeSocketVector', 'Init Movement')
        self.inputs[-1].default_value = [0.0, 0.0, 0.0]
        self.inputs.new('NodeSocketFloat', 'Min Distance (m)')
        self.inputs[-1].default_value = 5.5
        self.inputs.new('NodeSocketFloat', 'Max Distance (m)')
        self.inputs[-1].default_value = 6.0
        self.inputs.new('NodeSocketFloat', 'Max Acceleration (m/Tick)')
        self.inputs[-1].default_value = 0.01
        self.inputs.new('NodeSocketFloat', 'Max Deceleration (m/Tick)')
        self.inputs[-1].default_value = 0.001
        self.inputs.new('NodeSocketFloat', 'Max Speed (m/Tick)')
        self.inputs[-1].default_value = 0.1
        self.inputs.new('NodeSocketBool', 'Stop on Reached')
        self.outputs.new('ArmNodeSocketAction', 'Reached')
        self.outputs.new('NodeSocketVector', 'Movement')

add_node(FollowNode, category='Value')
