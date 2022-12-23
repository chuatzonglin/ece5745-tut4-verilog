/*
 * File: hello-world.v
 * Project: build
 * Created Date: 2022-12-06 11:27:28
 * Author: Kuroba
 * Description:  
 * Compile and run using Icarus verilog
 * iverilog -g2012 -o hello-world hello-world.v && ./hello-world
 * -----
 * Last Modified: 2022-12-06 11:42:11
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2022 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */

module top ();
    initial begin
        $display("Welcome back, ");
        $display("Kuroba");
    end
endmodule


