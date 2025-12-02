module Mantissa_Multiplier (
    input wire clk,
    input wire rst_n, // Reset tích cực mức thấp
    input wire [23:0] A_m,
    input wire [23:0] B_m,
    output reg [47:0] Out_m
);

    // Khai báo các thanh ghi trung gian cho Pipeline 3 giai đoạn (3-stage)
    // Giai đoạn 1: Đệm đầu vào (Input Registers)
    reg [23:0] reg_A, reg_B;
    
    // Giai đoạn 2: Tính toán và lưu kết quả trung gian (thường DSP block sẽ handle việc này)
    reg [47:0] mult_result;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            reg_A <= 24'd0;
            reg_B <= 24'd0;
            mult_result <= 48'd0;
            Out_m <= 48'd0;
        end else begin
            // Stage 1: Lấy mẫu đầu vào
            reg_A <= A_m;
            reg_B <= B_m;

            // Stage 2: Thực hiện nhân (Synthesis tool sẽ mapping vào DSP Register)
            mult_result <= reg_A * reg_B;

            // Stage 3: Đưa ra output
            Out_m <= mult_result;
        end
    end

endmodule