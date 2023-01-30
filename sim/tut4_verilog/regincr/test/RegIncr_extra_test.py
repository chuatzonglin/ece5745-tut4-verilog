#=========================================================================
# RegIncr_extra_test
#=========================================================================

import random
import pytest

from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim
from ..RegIncr import RegIncr

#-------------------------------------------------------------------------
# test_small
#-------------------------------------------------------------------------

def test_small( cmdline_opts ):
  run_test_vector_sim( RegIncr(), [
    ('in_   out*'),
    [ 0x00, '?'  ],
    [ 0x03, 0x01 ],
    [ 0x06, 0x04 ],
    [ 0x00, 0x07 ],
  ], cmdline_opts )

#-------------------------------------------------------------------------
# test_large
#-------------------------------------------------------------------------

def test_large( cmdline_opts ):
  run_test_vector_sim( RegIncr(), [
    ('in_   out*'),
    [ 0xa0, '?'  ],
    [ 0xb3, 0xa1 ],
    [ 0xc6, 0xb4 ],
    [ 0x00, 0xc7 ],
  ], cmdline_opts )

# ''' TUTORIAL TASK ''''''''''''''''''''''''''''''''''''''''''''''''''''''
# This test script is incomplete. As part of the tutorial you will add
# another test case to test for overflow. Later you will add a test case
# for random testing.
# ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#-------------------------------------------------------------------------
# test_overflow
#-------------------------------------------------------------------------

def test_overflow( cmdline_opts ):
  run_test_vector_sim( RegIncr(), [
    ('in_   out*'),
    [ 0xfe, '?'  ],
    [ 0xff, 0xff ],
    [ 0x00, 0x00 ],
  ], cmdline_opts )

#-------------------------------------------------------------------------
# mk_test_vector_table
#-------------------------------------------------------------------------
def mk_test_vector_table( nbits, inputs ):
  # Add initial invalid outputs to the list of output values
  output_val = ['?']
  
  # Calculate the value for sum and carry out
  for x in inputs:
    output_val.append(
      x+1 if x < 2**nbits - 1 else 0
    )
  
  # Additional 0 to finish the output
  inputs.append(0)

  # Put inputs_val and outputs_val together to make test_vector_table
  test_vector_table = [ ('in_   out*') ]
  for in_, out in zip(inputs, output_val):
    test_vector_table.append( 
      [in_, out]
      )
  return test_vector_table

#-------------------------------------------------------------------------
# test_random
#-------------------------------------------------------------------------
@pytest.mark.parametrize("N", [i for i in range(4, 10, 2)])
def test_random( N, cmdline_opts ):
  nbits = 8
  min_val = 0
  max_val = 2**nbits - 1
  run_test_vector_sim( RegIncr(), 
    mk_test_vector_table(nbits,
      [random.randint(min_val, max_val) for _ in range(N)]
      ), 
    cmdline_opts )