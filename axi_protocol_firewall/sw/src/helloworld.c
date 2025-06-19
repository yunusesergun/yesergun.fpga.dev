#define __MICROBLAZE__

#include "xparameters.h"
#include "xintc.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "sleep.h"
#include "platform.h"
#include "xuartlite.h"


// Interrupt Controller Definitions
#define INTC_DEVICE_ID       0
#define INTC_INTERRUPT_ID    0

// Interrupt Controller
XIntc InterruptController;

// UartLite
XUartLite UartLite;


// Callback Function
void MyInterruptHandler() {
    // Enable Firewall
	Xil_Out32(XPAR_AXI_FIREWALL_0_BASEADDR + 0x8, 0x1);

    // Print
    xil_printf("Executing Callback Function.\r\n");

    // Wait for a while
    sleep(1);
}

// Interrupt Controller Setup Function
int SetupInterruptSystem() {
    int Status;

    // Interrupt Controller Initialization
    Status = XIntc_Initialize(&InterruptController,
                              INTC_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("Interrupt Controller Initialization Failed!\r\n");
        return XST_FAILURE;
    }

    // Connect Interrupt Handler Function to Callback Function
    Status = XIntc_Connect(&InterruptController,
                           INTC_INTERRUPT_ID,
                           (XInterruptHandler)MyInterruptHandler,
                           NULL);
    if (Status != XST_SUCCESS) {
        xil_printf("Failed to Connect Interrupt Handler!\r\n");
        return XST_FAILURE;
    }

    // Start Interrupt Controller
    Status = XIntc_Start(&InterruptController,
                         XIN_REAL_MODE);
    if (Status != XST_SUCCESS) {
        xil_printf("Interrupt Controller Start Failed!\r\n");
        return XST_FAILURE;
    }

    // Enable Interrupt
    XIntc_Enable(&InterruptController, INTC_INTERRUPT_ID);

    // Enable Exceptions
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XIntc_InterruptHandler,
                                 &InterruptController);
    Xil_ExceptionEnable();

    // Print Success
    xil_printf("Interrupt System Initialized Successfully.\r\n");

    return XST_SUCCESS;
}

// Main Function
int main()
{
    // Init Platform
    init_platform();

    // Variable Definition
    int Status;
    int Counter = 0;

    // Initialize UartLite
    Status = XUartLite_Initialize(&UartLite,
                                  XPAR_AXI_UARTLITE_BASEADDR);
    if (Status != XST_SUCCESS) {
        xil_printf("Failed to Initialize Uart Lite\r\n");
        return XST_FAILURE;
    }


    // Enable AXI Firewall Interrupt
    Xil_Out32(XPAR_AXI_FIREWALL_0_BASEADDR + 0x200, 0xFFFFFFFF);  // Global Interrupt
    Xil_Out32(XPAR_AXI_FIREWALL_0_BASEADDR + 0x204, 0xFFFFFFFF);  // Interrupt
    Xil_Out32(XPAR_AXI_FIREWALL_0_BASEADDR + 0x208, 0xFFFFFFFF);  // Interrupt


    // Setup Interrupts (Interrupt Controller)
    Status = SetupInterruptSystem();
    if (Status != XST_SUCCESS) {
        xil_printf("Failed to Initialize Interrupt System\r\n");
        return XST_FAILURE;
    }

    // While Loop
    while (1) {
        xil_printf("Counter value: %d\r\n", Counter);
        sleep(1);
        Counter++;
    }

    // Cleanup
    cleanup_platform();
    return 0;
}
