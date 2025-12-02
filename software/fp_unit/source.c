#include <stdio.h>
#include <system.h>
#include <io.h>

#define FPU_BASE 0x00011000
#define FPU_RS1  (FPU_BASE + 0x00)
#define FPU_RS2  (FPU_BASE + 0x04)
#define FPU_CTRL (FPU_BASE + 0x08)
#define FPU_RESULT (FPU_BASE + 0x0C)
#define FPU_STATUS (FPU_BASE + 0x10)

int fpu_operation(unsigned int rs1_hex, unsigned int rs2_hex, unsigned char op) {
    printf("Input rs1_hex: 0x%08x\n", rs1_hex);
    IOWR_32DIRECT(FPU_RS1, 0, rs1_hex);
    printf("Wrote in_rs1: 0x%08x\n", rs1_hex);

    printf("Input rs2_hex: 0x%08x\n", rs2_hex);
    IOWR_32DIRECT(FPU_RS2, 0, rs2_hex);
    printf("Wrote in_rs2: 0x%08x\n", rs2_hex);

    unsigned int ctrl = (op & 0x3) | (1 << 2);
    IOWR_32DIRECT(FPU_CTRL, 0, ctrl);
    printf("Wrote control: op=%d, start=1 (0x%08x)\n", op, ctrl);

    int timeout = 5000000;
    while (IORD_32DIRECT(FPU_STATUS, 0) & 0x1) {
        if (--timeout == 0) {
            printf("Error: FPU operation timeout (op=%d)\n", op);
            return -1;
        }
    }
    printf("FPU completed (stall = 0) for op=%d\n", op);

    unsigned int result = IORD_32DIRECT(FPU_RESULT, 0);
    printf("Result: 0x%08x\n", result);
    return 0;
}

int main(void) {
    printf("Starting FPU Test on Altera DE2\n");


    printf("Addition (6.0 + 2.0):\n");
    if (fpu_operation(0x40c00000, 0x40000000, 0) != 0) {
        printf("Addition failed\n");
    }

    printf("Subtraction (6.0 - 2.0):\n");
    if (fpu_operation(0x40c00000, 0x40000000, 1) != 0) {
        printf("Subtraction failed\n");
    }

    printf("Multiplication (6.0 * 2.0):\n");
    if (fpu_operation(0x40c00000, 0x40000000, 2) != 0) {
        printf("Multiplication failed\n");
    }


    printf("Division (6.0 / 2.0):\n");
    if (fpu_operation(0x40c00000, 0x40000000, 3) != 0) {
        printf("Division failed\n");
    }

    printf("FPU Test Completed\n");
    while (1) {}
    return 0;
}
