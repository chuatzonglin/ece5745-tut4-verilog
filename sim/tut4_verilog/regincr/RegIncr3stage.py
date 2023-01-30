#!/usr/bin/env python
# -*- coding:utf-8 -*-
###
# File: RegIncr3stage.py
# Project: regincr
# Created Date: 2023-01-30 17:29:20
# Author: Kuroba
# Description: 
# -----
# Last Modified: 2023-01-30 17:32:10
# Modified By: Kuroba
# -----
# MIT License
# Copyright (c) 2023 Kuroba
# -----
# HISTORY:
# Date      	By	Comments
# ----------	---	----------------------------------------------------------
###

from pymtl3 import *
from pymtl3.passes.backends.verilog import *

class RegIncr3stage(VerilogPlaceholder, Component):

    # Constructor
    def construct(s):

        # Port-based interface
        s.in_ =  InPort(8)
        s.out = OutPort(8)