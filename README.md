# ADNS3080_frame_capture
This repo contains a python script and an arduino sketch to render the output of an ADNS3080 mouse sensor as a grayscale image. This is ideal for focusing the lens on the sensor as its obvious when an image is blurry. Doing so greatly improves the SQUAL value and the subsequent motion detection. 

The script was written in __python 3__ and requires the [pyserial library](https://pythonhosted.org/pyserial/pyserial.html#overview). The arduino sketch makes use of the [ADNS3080 library](https://github.com/RCmags/ADNS3080). Credit goes to [Lauszus](https://github.com/Lauszus/ADNS3080) for the inspiration. The script is largely based on his work.

Both files work in conjunction and must have the same __baud rate__ and __begin character__. This last value controls when the python script starts and stops receiving information from the arduino. 

A properly focused camera should generate these kinds of images:

<img src = "images/car.png" width = "30%" height = "30%"> <img src = "images/hand.png" width = "30%" height = "30%"> <img src = "images/ruler.png" width = "30%" height = "30%">
