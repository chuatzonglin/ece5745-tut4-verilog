#!/usr/bin/env python
# -*- coding:utf-8 -*-
###
# File: MinMaxUnit_test.py
# Project: test
# Created Date: 2023-01-31 15:54:10
# Author: Kuroba
# Description: 
# -----
# Last Modified: 2023-01-31 16:27:20
# Modified By: Kuroba
# -----
# MIT License
# Copyright (c) 2023 Kuroba
# -----
# HISTORY:
# Date      	By	Comments
# ----------	---	----------------------------------------------------------
###

#=========================================================================
# MinMaxUnit_test
#=========================================================================

import pytest
import random
from copy import deepcopy

random.seed(0xdeadbeef)

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim

from ..MinMaxUnit import MinMaxUnit

#-------------------------------------------------------------------------
# Syntax helpers
#-------------------------------------------------------------------------

# We define the header string here since it is so long. Then reference
# the header string and include a comment to label each of the columns.

header_str = \
    ( "in0",   "in1",  "out_min*",  "out_max*")

# We define a global variable 'x' so that we can simply use the x
# character instead of '?' to indicate don't care reference outputs

x = '?'

#-------------------------------------------------------------------------
# mk_test_vector_table
#-------------------------------------------------------------------------

def mk_test_vector_table( inputs ):

  # Add initial invalid outputs to the list of output values

  outputs_val = []

  # Sort inputs 

  inputs_val  = []
  for input_ in inputs:
    inputs_val.append( input_ )
    outputs_val.append( deepcopy( sorted(input_) ) )

  # Add final invalid inputs to the list of input values


  # Put inputs_val and outputs_val together to make test_vector_table

  test_vector_table = [ header_str ]
  for input_,output in zip( inputs_val, outputs_val ):
    test_vector_table.append( input_ + output )

  return test_vector_table

#-------------------------------------------------------------------------
# test basic
#-------------------------------------------------------------------------
def test_basic( cmdline_opts ):
  run_test_vector_sim(  MinMaxUnit(8), [ header_str,
    # in0 in1 out_min out_max
    [ 0,  1,  0,      1,  ],
    [ 1,  1,  1,      1,  ],
    [ 5,  3,  3,      5,  ],
    [ 8,  9,  8,      9,  ],
  ], cmdline_opts )

#-------------------------------------------------------------------------
# test random
#-------------------------------------------------------------------------
@pytest.mark.parametrize( "nbits", [ 4, 8, 16, 32 ] )
def test_random( nbits, cmdline_opts ):
  tvec_random = \
    [ [ random.randint(0,2**nbits-1) for _ in range(2) ] for _ in range(20) ]
  run_test_vector_sim( MinMaxUnit(nbits), \
    mk_test_vector_table(tvec_random), \
    cmdline_opts )