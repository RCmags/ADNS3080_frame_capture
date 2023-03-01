# ADNS3080_frame_capture
This repo contains a __python script__ and an __arduino sketch__ to render the output of an ADNS3080 mouse sensor as a grayscale image. This is ideal for focusing the lens as its obvious when an image is blurry. Doing so greatly improves the SQUAL value and subsequent motion detection. 

Both files work in conjunction and must have the same __baud rate__ and __begin character__. This last value controls when the python script receives information from the arduino. 

A properly focused camera should generate these kinds of images:

<img src = "images/car.png" width = "30%" height = "30%"> <img src = "images/hand.png" width = "30%" height = "30%"> <img src = "images/ruler.png" width = "30%" height = "30%">

## Requirements

- The script uses __python 3__ 
- The script requires the [pyserial](https://pythonhosted.org/pyserial/pyserial.html#overview) library. 
- The script requires the [tkinter](https://www.pythonguis.com/installation/install-tkinter-linux/) library.
- The Arduino sketch makes use of the [ADNS3080 library](https://github.com/RCmags/ADNS3080). 

## References

Credit goes to [Lauszus](https://github.com/Lauszus/ADNS3080) for the inspiration. The script is largely based on his work.

