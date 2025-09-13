#include "xparameters.h"
#include "xhwicap.h"
#include "xil_printf.h"
#include "xuartlite.h"
#include <stdio.h>
#include "sleep.h"


#define HWICAP_DEVICE_ID    XPAR_HWICAP_0_DEVICE_ID
#define UARTLITE_DEVICE_ID  XPAR_UARTLITE_0_DEVICE_ID


int main(void) {
    // Xilinx IP related variables
    XHwIcap_Config *ConfigPtr;
    XHwIcap HwIcap;
    XUartLite UartLite;
    XUartLite_Config *UartConfig;

    // Other variables
    u8 ReceivedChar;
    int Status;
    int counter = 0;
    u32 read_data;


    // HWICAP Lookup Config
    ConfigPtr = XHwIcap_LookupConfig(HWICAP_DEVICE_ID);
    if (ConfigPtr == NULL) {
        xil_printf("HWICAP LookupConfig Basarisiz\r\n");
        return XST_FAILURE;
    }

    // HWICAP IP Initialization
    Status = XHwIcap_CfgInitialize(&HwIcap, ConfigPtr, ConfigPtr->BaseAddress);
    if (Status != XST_SUCCESS) {
        xil_printf("HWICAP CfgInitialize Basarisiz\r\n");
        return XST_FAILURE;
    }

    // UART Lite Lookup Config
    UartConfig = XUartLite_LookupConfig(UARTLITE_DEVICE_ID);
    if (UartConfig == NULL) {
        xil_printf("UART LookupConfig Basarisiz\r\n");
        return XST_FAILURE;
    }

    // UART Lite Initialization
    Status = XUartLite_CfgInitialize(&UartLite, UartConfig, UartConfig->RegBaseAddr);
    if (Status != XST_SUCCESS) {
        xil_printf("UART CfgInitialize Basarisiz\r\n");
        return XST_FAILURE;
    }

    // Sleep for 5 seconds because we want to connect via COM
    sleep(5);

    xil_printf("UART ve HWICAP Hazir. '3' girildiginde IPROG gonderilecek.\r\n");
    xil_printf("3 disinda bir karakter girdiginizde sayac gonderilir.\r\n");

    // Get BOOTSTS
    XHwIcap_GetConfigReg(&HwIcap, XHI_BOOTSTS, &read_data);
    xil_printf("Boot History Register: 0x%x\n", read_data);

    while (1) {
        // Each second we check UART Lite
        sleep(1);

        // Read 1 Byte from UART Lite
        XUartLite_Recv(&UartLite, &ReceivedChar, 1);

        // If the byte read is 0x3
		if (ReceivedChar == 3) {
			// send IPROG command
			u32 WriteData[5];
			WriteData[0] = 0xFFFFFFFF;
			WriteData[1] = 0xAA995566; // Sync Word
			WriteData[2] = 0x20000000; // NOOP
			WriteData[3] = 0x30008001; // Write command to CMD register (1 word)
			WriteData[4] = 0x0000000F; // IPROG command

            // Write to HWICAP IP
			Status = XHwIcap_DeviceWrite(&HwIcap, WriteData, 5);
			if (Status != XST_SUCCESS) {
				xil_printf("HWICAP DeviceWrite Basarisiz\r\n");
			} else {
				xil_printf("IPROG komutu gonderildi. FPGA yeniden konfigure olacak.\r\n");
			}

			// After IPROG, the codes does not come to here
			break;
		} else {
			// if the byte read is not 0x3, print counter value which increments each second
			char buffer[32];
			snprintf(buffer, sizeof(buffer), "Counter = %d\r\n", counter);
			XUartLite_Send(&UartLite, (u8 *)buffer, strlen(buffer));
			counter++;
		}
    }

    return XST_SUCCESS;
}
