#ifndef SRC_MANAGERS_IMAGECAPTUREMANAGER_H_
#define SRC_MANAGERS_IMAGECAPTUREMANAGER_H_

#include "imageCaptureState.h"
#include "dragsterConfig.h"
#include "pixelFrequencies.h"
#include "xspi.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_assert.h"

class ImageCaptureManager
{
public:
    void initialize();
    void startImageCapture();
    void stopImageCapture();
    DragsterConfig getDragsterConfig(unsigned char linescannerIndex);
private:
    void configureInterrupts();
    // dragster
    void initializeSpi();
    void initializeDragsters();
    void initializeDragsterImpl(DragsterConfig* config, int dragsterSlaveSelectMask);
    void readDragsterConfigImpl(DragsterConfig* config, int dragsterSlaveSelectMask);
    void sendDragsterRegisterValue(unsigned char address, unsigned char value);
    unsigned char readDragsterRegisterValue(unsigned char address);
    void beginDragsterConfigTransaction();
    void endDragsterConfigTransaction();
private:
    // interrupt controller
    XScuGic _interruptController;
    // dragster entities
    XSpi _spi;
    ImageCaptureState _imageCaptureState;
    DragsterConfig _linescanner0Config;
    DragsterConfig _linescanner1Config;
};


#endif /* SRC_MANAGERS_IMAGECAPTUREMANAGER_H_ */
