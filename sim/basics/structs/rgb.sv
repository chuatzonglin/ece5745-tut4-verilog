/*
 * File: rgb.sv
 * Project: structs
 * Created Date: 2023-01-30 00:21:35
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2023-01-30 00:31:04
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2023 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */



typedef struct packed {

    logic [7:0] red;
    logic [7:0] green;
    logic [7:0] blue;

} pixel_t;

module top;

    pixel_t pixel_1;
    pixel_t pixel_2;

    initial begin
        pixel_1.red = 8'd128;
        pixel_1.green = 8'd1;
        pixel_1.blue = 8'd300;

        $display("pixel_1.red = %d", pixel_1.red);
        $display("pixel_1.green = %d", pixel_1.green);
        $display("pixel_1.blue = %d", pixel_1.blue);

        pixel_2 = {8'd91, 8'd93, 8'd9};

        $display("pixel_2.red = %d", pixel_2.red);
        $display("pixel_2.green = %d", pixel_2.green);
        $display("pixel_2.blue = %d", pixel_2.blue);

        
    end
    
endmodule