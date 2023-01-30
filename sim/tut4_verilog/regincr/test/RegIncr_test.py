#=========================================================================
# RegIncr_test
#=========================================================================

import random

from pymtl3 import *
from pymtl3.stdlib.test_utils import config_model_with_cmdline_opts

from ..RegIncr import RegIncr

# In pytest, unit tests are simply functions that begin with a "test_"
# prefix. PyMTL3 is setup to collect command line options. Simply specify
# "cmdline_opts" as an argument to your unit test source code,
# and then you can dump VCD by adding --dump-vcd option to pytest
# invocation from the command line.

random.seed(0xdeadbeef)

def mk_tvec(in_vals, nbits = 8):
  tvec = []
  out_vals = ['?']
  
  for in_ in in_vals:
    out_vals.append(in_ + 1 if in_ < 2**nbits - 1 else 0)
    tvec.append([in_, out_vals.pop(0)])
  return tvec

def test_basic( cmdline_opts ):

  # Create the model

  model = RegIncr()

  # Configure the model

  model = config_model_with_cmdline_opts( model, cmdline_opts, duts=[] )

  # Create and reset simulator

  model.apply( DefaultPassGroup(linetrace=True) )
  model.sim_reset()

  # Helper function

  def t( in_, out ):

    # Write input value to input port

    model.in_ @= in_

    # Ensure that all combinational concurrent blocks are called

    model.sim_eval_combinational()

    # If reference output is not '?', verify value read from output port

    if out != '?':
      assert model.out == out

    # Tick simulator one cycle

    model.sim_tick()

  # ''' TUTORIAL TASK ''''''''''''''''''''''''''''''''''''''''''''''''''''
  # This test script is incomplete. As part of the tutorial you will
  # insert a sequence of test cases that use the above helper function to
  # set the input and verify the output of the registered incrementer.
  # ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

  tvec = mk_tvec([random.randint(0, 2**8 - 1) for _ in range(10)])

  for (in_, out) in tvec:
    t(in_, out)