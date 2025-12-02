module FP_Unit_Wrapper (
    input iClk,
    input iReset_n,
    input iChipSelect_n,
    input iWrite_n,
    input iRead_n,
    input [1:0] iAddress,
    input [31:0] iData,
    output reg [31:0] oData
);
    // Internal registers for FP_Unit inputs
    reg [31:0] reg_rs1;       // Thanh ghi lưu in_rs1
    reg [31:0] reg_rs2;       // Thanh ghi lưu in_rs2
    reg [1:0]  reg_FPU_Op;    // Thanh ghi lưu in_FPU_Op
    reg        reg_start;     // Thanh ghi lưu in_start

    // Internal wires for FP_Unit outputs
    wire [31:0] fp_out_data;  // Kết quả từ FP_Unit
    wire        fp_out_stall; // Tín hiệu stall từ FP_Unit

    // Instantiate FP_Unit
    FP_Unit fp_unit_inst (
        .in_Clk(iClk),
        .in_Rst_N(iReset_n),
        .in_start(reg_start),
        .in_FPU_Op(reg_FPU_Op),
        .in_rs1(reg_rs1),
        .in_rs2(reg_rs2),
        .out_data(fp_out_data),
        .out_stall(fp_out_stall)
    );

    // Logic ghi và đọc
    always @(posedge iClk or negedge iReset_n) begin
        if (~iReset_n) begin
            oData <= 32'd0;
            reg_rs1 <= 32'd0;
            reg_rs2 <= 32'd0;
            reg_FPU_Op <= 2'b00;
            reg_start <= 1'b0;
        end else begin
            // Ghi dữ liệu khi iChipSelect_n = 0 và iWrite_n = 0
            if (~iChipSelect_n & ~iWrite_n) begin
                case (iAddress)
                    2'd0: reg_rs1 <= iData;
                    2'd1: reg_rs2 <= iData;
                    2'd2: begin
                        reg_FPU_Op <= iData[1:0];
                        reg_start <= iData[2];
                    end
                    default: begin
                        reg_rs1 <= reg_rs1;
                        reg_rs2 <= reg_rs2;
                        reg_FPU_Op <= reg_FPU_Op;
                        reg_start <= reg_start;
                    end
                endcase
            end
            // Đọc dữ liệu khi iChipSelect_n = 0 và iRead_n = 0
            if (~iChipSelect_n & ~iRead_n) begin
                case (iAddress)
                    2'd0: oData <= reg_rs1;
                    2'd1: oData <= reg_rs2;
                    2'd2: oData <= {29'h0, reg_start, reg_FPU_Op}; // Trả về điều khiển và stall sau khi hoàn thành
                    2'd3: oData <= fp_out_data; // Trả về kết quả khi phép toán hoàn thành
                    default: oData <= 32'h0;
                endcase
            end
            // Reset reg_start khi phép toán hoàn thành
            if (!fp_out_stall && reg_start) begin
                reg_start <= 1'b0;
            end
        end
    end
endmodule