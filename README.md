# ADNS3080_frame_capture
This repo contains a python script and an arduino sketch to render the output of an ADNS3080 mouse sensor as a grayscale image. 

The script was written in __python 3__  and requires the [pyserial library](https://pythonhosted.org/pyserial/pyserial.html#overview).
The arduino sketch makes use of the [ADNS3080 library](https://github.com/RCmags/ADNS3080).  

Both of these files work in conjunction to generate an image. To this end, both files must have the same __baud rate__ and __begin character__. This last value controls when the python script starts and stop receiving information from the arduino. 

This script is ideal for focusing the lens on the sensor as its obvious when an image is blurry. Doing so greatly improves the SQUAL value and the subsequent motion detection. 
