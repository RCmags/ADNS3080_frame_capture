import serial
import tkinter

#--------------- Constants --------------------------

# Pixel grid
WINDOW_SIZE = 400
NUM_PIXEL   = 30

# Serial communication [Must match arduino sketch]
BAUD_RATE   = 57600
SERIAL_PORT = 'COM5'
BEGIN_CHAR  = 'A'

# Depedent constants
PIXEL_SIZE  = WINDOW_SIZE/NUM_PIXEL
DELAY_MSEC  = int( 1000*( 4*NUM_PIXEL*NUM_PIXEL )/BAUD_RATE )

#--------------- Variable initialization ------------

# Display window:
window = tkinter.Tk()
canvas = tkinter.Canvas( window, height = WINDOW_SIZE, width = WINDOW_SIZE )

# Pixel elements:
pixel = []
color = []

    # Scan grid
for y in range( 0, NUM_PIXEL ):
    pixel.append( [] )
    color.append( [] )
    for x in range( 0, NUM_PIXEL ):
        color[y].append(0)
        pixel[y].append( canvas.create_rectangle(  PIXEL_SIZE*x,                PIXEL_SIZE*y,
                                                   PIXEL_SIZE*x + PIXEL_SIZE,   PIXEL_SIZE*y + PIXEL_SIZE,
                                                   fill = "black",              width = 0                   ) )                                 

#--------------- Functions --------------------------

def getData():
    try:
        return arduino.readline().decode( "utf-8" )
    except:
        return ""

def hexColor( byte ):
    return "#%02x%02x%02x" % (byte, byte, byte)

def setPixelColor():    
    # Find start character:
    data = getData()
    
    while BEGIN_CHAR not in data:   
        data = getData()

    # Scan frame:
    for y in range( 0, NUM_PIXEL ):
        for x in range( 0, NUM_PIXEL ):
            try:
                color[x][y] = int( getData() )
            except:
                continue
            
    # Set pixel color:    
    for y in range( 0, NUM_PIXEL ): 
        for x in range( 0, NUM_PIXEL ):
            try:
                canvas.itemconfig( pixel[x][y], fill = hexColor( color[x][y] ) )
            except:
                continue
            
def updateImage(): 
    setPixelColor()
    canvas.after( DELAY_MSEC, updateImage )

#--------------- Program execution ------------------

try:
    # Make connection
    arduino = serial.Serial( SERIAL_PORT, BAUD_RATE, timeout = float(DELAY_MSEC)/1000 )
    print( "Successful connection" )

    # Update image
    canvas.pack()
    canvas.after( DELAY_MSEC, updateImage )
    window.mainloop()
    arduino.close()
except:
    print( "Connection failure" )

