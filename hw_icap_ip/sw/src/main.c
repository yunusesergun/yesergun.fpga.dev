#include "xparameters.h"
#include "xhwicap.h"
#include "xil_printf.h"
#include "xuartlite.h"
#include <stdio.h>
#include "sleep.h"


#define HWICAP_DEVICE_ID    XPAR_HWICAP_0_DEVICE_ID
#define UARTLITE_DEVICE_ID  XPAR_UARTLITE_0_DEVICE_ID


int main(void) {
    int Status;
    XHwIcap_Config *ConfigPtr;
    XHwIcap HwIcap;
    XUartLite UartLite;
    XUartLite_Config *UartConfig;
    u8 ReceivedChar;
    int counter = 0;

    // HWICAP yapılandırması
    ConfigPtr = XHwIcap_LookupConfig(HWICAP_DEVICE_ID);
    if (ConfigPtr == NULL) {
        xil_printf("HWICAP LookupConfig Basarisiz\r\n");
        return XST_FAILURE;
    }

    Status = XHwIcap_CfgInitialize(&HwIcap, ConfigPtr, ConfigPtr->BaseAddress);
    if (Status != XST_SUCCESS) {
        xil_printf("HWICAP CfgInitialize Basarisiz\r\n");
        return XST_FAILURE;
    }

    // UART Lite yapılandırması
    UartConfig = XUartLite_LookupConfig(UARTLITE_DEVICE_ID);
    if (UartConfig == NULL) {
        xil_printf("UART LookupConfig Basarisiz\r\n");
        return XST_FAILURE;
    }

    Status = XUartLite_CfgInitialize(&UartLite, UartConfig, UartConfig->RegBaseAddr);
    if (Status != XST_SUCCESS) {
        xil_printf("UART CfgInitialize Basarisiz\r\n");
        return XST_FAILURE;
    }

    xil_printf("UART ve HWICAP Hazir. '3' girildiginde IPROG gonderilecek.\r\n");
    xil_printf("3 disinda bir karakter girdiginizde sayac gonderilir.\r\n");

    while (1) {
        // Her saniye bir kez kontrol edeceğiz
        sleep(1);

        // UART'tan 1 byte okumaya çalış
        XUartLite_Recv(&UartLite, &ReceivedChar, 1);

		if (ReceivedChar == 3) {
			// IPROG komutunu gönder
			u32 WriteData[5];
			WriteData[0] = 0xFFFFFFFF;
			WriteData[1] = 0xAA995566; // Sync Word
			WriteData[2] = 0x20000000; // NOOP
			WriteData[3] = 0x30008001; // CMD register'a yazma komutu (1 kelime)
			WriteData[4] = 0x0000000F; // IPROG komutu

			Status = XHwIcap_DeviceWrite(&HwIcap, WriteData, 5);
			if (Status != XST_SUCCESS) {
				xil_printf("HWICAP DeviceWrite Basarisiz\r\n");
			} else {
				xil_printf("IPROG komutu gonderildi. FPGA yeniden konfigure olacak.\r\n");
			}

			// IPROG gönderildikten sonra FPGA resetleneceği
            // için buradan sonra kodun çalışması beklenmez.
			break;
		} else {
			// Gelen veri '3' değil, counter değerini UART üzerinden yaz
			char buffer[32];
			snprintf(buffer, sizeof(buffer), "Counter = %d\r\n", counter);
			XUartLite_Send(&UartLite, (u8 *)buffer, strlen(buffer));
			counter++;
		}
    }

    return XST_SUCCESS;
}
