#include <ADNS3080.h>

// SPI pins:
#define PIN_RESET    9
#define PIN_CS       10

ADNS3080<PIN_RESET, PIN_CS> sensor;

// Serial parameters: [Must match python script]
#define BEGIN_CHAR    'A'
#define BAUD_RATE     57600

void setup() {
  // Initialize sensor
  sensor.setup( false, false );
  
  // Set baud rate
  Serial.begin(BAUD_RATE);

  // Prevent random character
  Serial.flush();
  
  // Indicate new frame
  Serial.println( BEGIN_CHAR );
}

void loop() {
  // Get frame data
  uint8_t frame[ADNS3080_PIXELS_X][ADNS3080_PIXELS_Y];
  sensor.frameCapture( frame );

  // Scan grid and send pixel color
  for( int y = 0; y < ADNS3080_PIXELS_Y; y += 1 ) {
    for( int x = 0; x < ADNS3080_PIXELS_X; x += 1 ) {
      Serial.println( frame[x][y] );
    }
  }
  // Indicate new frame
  Serial.println( BEGIN_CHAR );     
}
