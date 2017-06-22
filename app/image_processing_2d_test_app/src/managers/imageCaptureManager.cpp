#include "imageCaptureManager.h"
#include "axiIoHelper.h"
#include "modulesMap.h"
#include "globalDefs.h"
#include "xparameters.h"
#include "xil_exception.h"

#define SPI_DEVICE_ID XPAR_SPI_0_DEVICE_ID

#define START_COMMAND 1
#define STOP_COMMAND 2
#define RESET_COMMAND 3

#define LINESCANNER0_SLAVE_SELECT 1
#define LINESCANNER1_SLAVE_SELECT 2

#define FREQUENCY_ANALYZER_0_INTERRUPT_ID XPAR_FABRIC_FREQUENCY_ANALYZER_MANAGER_0_IRQ_INTR
#define FREQUENCY_ANALYZER_1_INTERRUPT_ID XPAR_FABRIC_FREQUENCY_ANALYZER_MANAGER_1_IRQ_INTR

#define INTERRUPT_CONTROLLER_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID

PixelFrequencies linescanner0PixelFrequencies;
PixelFrequencies linescanner1PixelFrequencies;

void clearFrequencies()
{
	linescanner0PixelFrequencies._counter = 0;
    linescanner0PixelFrequencies._pixel0Frequency0 = 0;
    linescanner0PixelFrequencies._pixel0Frequency1 = 0;
    linescanner0PixelFrequencies._pixel1Frequency0 = 0;
    linescanner0PixelFrequencies._pixel1Frequency1 = 0;
    linescanner0PixelFrequencies._pixel2Frequency0 = 0;
    linescanner0PixelFrequencies._pixel2Frequency1 = 0;
    linescanner0PixelFrequencies._pixel0UnassignedFrequency = 0;

    linescanner1PixelFrequencies._counter = 0;
    linescanner1PixelFrequencies._pixel0Frequency0 = 0;
    linescanner1PixelFrequencies._pixel0Frequency1 = 0;
    linescanner1PixelFrequencies._pixel1Frequency0 = 0;
    linescanner1PixelFrequencies._pixel1Frequency1 = 0;
    linescanner1PixelFrequencies._pixel2Frequency0 = 0;
    linescanner1PixelFrequencies._pixel2Frequency1 = 0;
    linescanner1PixelFrequencies._pixel0UnassignedFrequency = 0;
}

void freuqencyAnalyzer0Handler(void *data)
{
    linescanner0PixelFrequencies._counter++;
    // TODO: UMV: COMMENTED: BACEUSE LONG OPERATION BREAKES INTERUPT HANDLER 1
    //xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    //xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);
    linescanner0PixelFrequencies._pixel0Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 0);
    linescanner0PixelFrequencies._pixel0Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 4);
    linescanner0PixelFrequencies._pixel1Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 8);
    linescanner0PixelFrequencies._pixel1Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 12);
    linescanner0PixelFrequencies._pixel2Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 16);
    linescanner0PixelFrequencies._pixel2Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 20);
    linescanner0PixelFrequencies._pixel0UnassignedFrequency += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 24);
    linescanner0PixelFrequencies._pixel1UnassignedFrequency += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 28);
    linescanner0PixelFrequencies._pixel2UnassignedFrequency += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 32);
}

void freuqencyAnalyzer1Handler(void *data)
{
    linescanner1PixelFrequencies._counter++;
    // TODO: UMV: COMMENTED: BACEUSE LONG OPERATION BREAKES INTERUPT HANDLER 0
    //xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    //xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);
    linescanner1PixelFrequencies._pixel0Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 0);
    linescanner1PixelFrequencies._pixel0Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 4);
    linescanner1PixelFrequencies._pixel1Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 8);
    linescanner1PixelFrequencies._pixel1Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 12);
    linescanner1PixelFrequencies._pixel2Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 16);
    linescanner1PixelFrequencies._pixel2Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 20);
    linescanner1PixelFrequencies._pixel0UnassignedFrequency += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 24);
    linescanner1PixelFrequencies._pixel1UnassignedFrequency += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 28);
    linescanner1PixelFrequencies._pixel2UnassignedFrequency += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 32);
}

void ImageCaptureManager::initialize()
{
    configureInterrupts();
    configureFrequencyAnalyzerManagers();
}

void ImageCaptureManager :: startImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 1);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, START_COMMAND);
    xil_printf("\n Image Capture Manager has been started\n\r");
}

void ImageCaptureManager :: stopImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 2);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, STOP_COMMAND);
    xil_printf("\n Image Capture Manager has been stopped\n\r");
}

void ImageCaptureManager :: resetImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 2);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, RESET_COMMAND);
    xil_printf("\n Image Capture Manager has been reseted\n\r");
}

DragsterConfig* ImageCaptureManager :: getDragsterConfig(unsigned char linescannerIndex)
{
    if(linescannerIndex == LINESCANNER0)
       return &_linescanner0Config;
    else if(linescannerIndex == LINESCANNER1)
       return &_linescanner1Config;
    return NULL;
}

void ImageCaptureManager :: configureInterrupts()
{
    XScuGic_Config* config = XScuGic_LookupConfig(INTERRUPT_CONTROLLER_DEVICE_ID);
    if(!config)
        xil_printf("\n XScuGic_LookupConfig failed \r\n");
    int status = XScuGic_CfgInitialize(&_interruptController, config, config->CpuBaseAddress);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_CfgInitialize \r\n");
    // Set priority and trigger type.
    //    Priority range: 0...248.
    //    Trigger types:
    //        Software-generated Interrupts(SFI): 2(always);
    //        Private Peripheral Interrupt(PPI): 1(Active HIGH), 3(Rising edge);
    //        Shared Peripheral Interrupts(SPI): 1(Active HIGH), 3(Rising edge);*/
    XScuGic_SetPriorityTriggerType(&_interruptController, FREQUENCY_ANALYZER_0_INTERRUPT_ID, 0xA0, 0x3);
    XScuGic_SetPriorityTriggerType(&_interruptController, FREQUENCY_ANALYZER_1_INTERRUPT_ID, 0xA0, 0x3);

    status = XScuGic_Connect(&_interruptController, FREQUENCY_ANALYZER_0_INTERRUPT_ID,
                            (Xil_InterruptHandler)freuqencyAnalyzer0Handler, NULL);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_Connect failed (Frequency analyzer manager 0) \r\n");
    //
    status = XScuGic_Connect(&_interruptController,  FREQUENCY_ANALYZER_1_INTERRUPT_ID,
                             (Xil_InterruptHandler)freuqencyAnalyzer1Handler, NULL);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_Connect failed (Frequency analyzer manager 1) \r\n");

    XScuGic_Enable(&_interruptController,  FREQUENCY_ANALYZER_0_INTERRUPT_ID);
    XScuGic_Enable(&_interruptController,  FREQUENCY_ANALYZER_1_INTERRUPT_ID);

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, &_interruptController);

    Xil_ExceptionEnable();
}

void ImageCaptureManager :: configureFrequencyAnalyzerManagers()
{
	_analyzerManager0Configs.setThreshold(95);
	write(FREQUENCY_ANALYZER0_BASE_ADDRESS, THRESHOLD_INDEX * 4, _analyzerManager0Configs.getThreshold());
}
