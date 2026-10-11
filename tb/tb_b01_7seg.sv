

module b01_tb;

    reg  [3:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] expected;

    integer i;
    integer errors;
    integer tc_errors;

    b01_7seg dut (
        .ui_in(ui_in),
        .uo_out(uo_out)
    );

    // Giu nguyen bang ma dau ra cu
    function [7:0] expected_output;
        input [3:0] bcd;
        begin
            case (bcd)
                4'd0: expected_output = 8'b00000001;
                4'd1: expected_output = 8'b01001111;
                4'd2: expected_output = 8'b00010010;
                4'd3: expected_output = 8'b00000110;
                4'd4: expected_output = 8'b01001100;
                4'd5: expected_output = 8'b00100100;
                4'd6: expected_output = 8'b00100000;
                4'd7: expected_output = 8'b00001111;
                4'd8: expected_output = 8'b00000000;
                4'd9: expected_output = 8'b00000100;
                default: expected_output = 8'b11111111;
            endcase
        end
    endfunction

    // Kiem tra mot dau vao
    task check_output;
        input [7:0] test_id;
        begin
            expected = expected_output(ui_in);
            #1;

            if (uo_out !== expected) begin
                $display(
                    "FAIL TC%0d: input=%b actual=%b expected=%b",
                    test_id, ui_in, uo_out, expected
                );
                errors = errors + 1;
            end
            else begin
                $display(
                    "PASS TC%0d: input=%b output=%b",
                    test_id, ui_in, uo_out
                );
            end
        end
    endtask

    // Kiem tra mot ca chuyen tiep gom hai dau vao
    task check_transition;
        input [7:0] test_id;
        input [3:0] first_input;
        input [3:0] second_input;
        begin
            tc_errors = 0;

            ui_in = first_input;
            expected = expected_output(first_input);
            #1;

            if (uo_out !== expected) begin
                $display(
                    "  FAIL: input=%b actual=%b expected=%b",
                    ui_in, uo_out, expected
                );
                errors = errors + 1;
                tc_errors = tc_errors + 1;
            end

            #9;
            ui_in = second_input;
            expected = expected_output(second_input);
            #1;

            if (uo_out !== expected) begin
                $display(
                    "  FAIL: input=%b actual=%b expected=%b",
                    ui_in, uo_out, expected
                );
                errors = errors + 1;
                tc_errors = tc_errors + 1;
            end

            if (tc_errors == 0)
                $display(
                    "PASS TC%0d: transition %0d -> %0d",
                    test_id, first_input, second_input
                );
            else
                $display(
                    "FAIL TC%0d: transition %0d -> %0d (%0d errors)",
                    test_id, first_input, second_input, tc_errors
                );
        end
    endtask

    initial begin
        // Ghi waveform vao file VCD
        $dumpfile("docs/b01_wave.vcd");
        $dumpvars(0, b01_tb);

        errors = 0;
        tc_errors = 0;
        ui_in = 4'd0;
        expected = 8'd0;

        #10;

        // TC01-TC16: Kiem tra toan bo 16 gia tri dau vao
        for (i = 0; i < 16; i = i + 1) begin
            ui_in = i[3:0];
            check_output(i + 1);
            #9;
        end

        // TC17: Chuyen tu dau vao hop le 9 sang khong hop le 10
        check_transition(17, 4'd9, 4'd10);
        #9;

        // TC18: Chuyen tu dau vao khong hop le 15 ve hop le 8
        check_transition(18, 4'd15, 4'd8);
        #9;

        if (errors == 0)
            $display("B01 validation PASS: all checks passed");
        else
            $display("B01 validation FAIL: %0d errors", errors);

        $finish;
    end

endmodule
