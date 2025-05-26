/*
	ADNS3080 FRAME CAPTURE
	======================
	Processing sketch to view video output of ADNS3080 Mouse Sensor.
	See: https://github.com/RCmags/ADNS3080


	AUTHORS
	--------
	1. Program originally written by EllieOwen
	See: https://github.com/EllieOwen

	2. Minor Modifications made by RCmags
	See: https://github.com/RCmags
*/

import processing.serial.*;

Serial myPort;	  				// Create object from Serial class
String val;	    				// Data received from the serial port
								// Data should be an integer from 0 to 255 for grayscale images

boolean goodFrame = false; 		// found beginning of frame so we can begin the pixel indexing
String beginChar  = "A";

int pgSize; 					// width and height of pixel group
int frameSize 	  		= 30; 	// width of frame and assume square frame for height
int x 			  		= 0; 	// column number of captured image frame
int y 			  		= 0; 	// row number of captured image frame
int index 		  		= 0; 	// index of captured image frame pixel
int frameNum; 					// count the frames so we can compute frame rate
float fps;						// Frames per second
int m;							// Timer in milliseconds

const int BAUD_RATE   	= 57600; // Serial rate
const int CANVAS_SIZE	= 400;	 // Pixels of Rendered image
const int BG_COLOR 		= 200; 	 // Background color

void setup() {
  size(CANVAS_SIZE, CANVAS_SIZE);  	//make our canvas size
  background(BG_COLOR);

  //  initialize your serial port and set the baud rate to 57600
  //  may need to be slower on Arduino Uno

  myPort = new Serial(this, Serial.list()[0], BAUD_RATE); 
  loadPixels(); // Initialize pixel array
  pgSize = width / frameSize;
  m = millis();
}

void draw() {
  //we can leave the draw method empty, 
  //because all our programming happens in the serialEvent (see below)
  //updatePixels();
}

void serialEvent( Serial myPort) { 	//called every time serial data is detected
  int i;
  int j;
  int thisPixel;

  // put the incoming data into a String
  // the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n'); 	// data is sent one byte at a time

  // make sure our data isn't empty before continuing
  if (val != null) { 					// make sure there is data there

    // trim whitespace and formatting characters (like carriage return)
    val = trim(val);

    if (val.equals(beginChar)) {
      // start new frame
      goodFrame = true;
      x = 0;
      y = 0;
      index = 0;
      frameNum +=1;
    }
    else if (goodFrame) {  				// beginning of frame found and filling in each pixel group
      for (i = 0; i < pgSize; i+=1) { 
        for (j = 0; j < pgSize; j+=1) {
          thisPixel = (x * pgSize) + i + width * (y * pgSize + j);
          pixels[thisPixel] = color(int(val)); 	// this is a one dimentional array
        }
      }

      updatePixels();

      if (x == frameSize -1 && y == frameSize - 1) {
        goodFrame = false;
        fps = 1000 / (millis() - m);
        println(fps);
        m = millis();
      }
      else {
        index += 1; 

        x = (index % frameSize);	// what is the next x
        y = (index / frameSize);	// what is the next y
      }
    }
  }
}
