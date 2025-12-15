

# IEEE 754 Single-Precision Floating Point Unit (FPU) IP Core
## 📌 Overview
This repository contains the RTL implementation of a **32-bit Floating Point Unit (FPU)** compliant with the **IEEE 754 Standard**. The IP Core supports four arithmetic operations: Addition, Subtraction, Multiplication, and Division.

The design is further wrapped with an **Avalon-MM Slave Interface** to function as a hardware accelerator within an Altera **Nios II Embedded System**, providing significant performance acceleration compared to software emulation.
## 🚀 Key Features
* **Supported Operations:** 32-bit Floating-Point Add, Sub, Mul, Div.
* **Algorithm:** Implements **Newton-Raphson algorithm** for high-precision Division.
* **Pipeline Architecture:** Multi-stage pipeline design to maximize throughput.
* **Stall Control:** Robust `stall` logic to handle variable-latency operations (Division) and synchronize with the system bus.
* **Exception Handling:** Supports Overflow, Underflow, NaN, and Infinity.
* **Integration:** Wrapped as an **Avalon-MM Slave** for seamless integration with Nios II processors.
* ## 🛠️ System Architecture
  <img width="542" height="430" alt="image" src="https://github.com/user-attachments/assets/f6abe82a-956f-4207-b1df-b1ee1b6e15d5" />
##  Source Code Structure
* `FP_Unit.v`: Top-level module controlling the arithmetic logic. 
* `FP_Add.v` / `FP_Sub.v`: Adder and Subtractor logic with alignment and normalization.
* `FP_Mul.v`: Multiplier logic.
* `FP_Div.v`: Divider logic implementing Newton-Raphson iterations + State Machine.
* `FPU_Top.v`: Wrapper module for Avalon-MM interface and Nios II integration.

  <img width="881" height="456" alt="image" src="https://github.com/user-attachments/assets/c27c5d54-1d49-4ed4-853d-f35c3a6fbc17" />
  <img width="1117" height="415" alt="image" src="https://github.com/user-attachments/assets/069ea12e-a259-468d-805b-98fd7ae1d859" />
<img width="1099" height="451" alt="image" src="https://github.com/user-attachments/assets/30b56739-7853-4c5f-aac4-37d3d0c2d6ec" />
<img width="1544" height="627" alt="image" src="https://github.com/user-attachments/assets/216cec68-95dd-4031-9349-8f61a74b921f" />

