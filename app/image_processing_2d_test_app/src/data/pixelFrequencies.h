#ifndef SRC_DATA_PIXELFREQUENCIES_H_
#define SRC_DATA_PIXELFREQUENCIES_H_


struct PixelFrequencies
{
	unsigned int _pixel0Frequency0;
	unsigned int _pixel0Frequency1;

	unsigned int _pixel1Frequency0;
	unsigned int _pixel1Frequency1;

	unsigned int _pixel2Frequency0;
	unsigned int _pixel2Frequency1;

	unsigned int _counter;

    unsigned int _pixel0UnassignedFrequency;
    unsigned int _pixel1UnassignedFrequency;
    unsigned int _pixel2UnassignedFrequency;
};


#endif /* SRC_DATA_PIXELFREQUENCIES_H_ */
