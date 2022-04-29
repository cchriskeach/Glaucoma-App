# Glac-at-home-a
## Technical Documentation
### Purpose of the application:
#### Introduction
Glac-at-home-a is an application that is currently in the development stages but is being used in an National Science Foundation (NSF) funded grant research program. The goal of the research project is to create a device for at-home intraocular pressure reading (IOP) that will then send the data to a mobile phone so that the data can be viewed, and shipped to a server. The theoretical device which has not yet been fully developed would connect to the phone via Bluetooth Low Energy (BLE).
#### Aid Development Process
Since at the current moment the intraocular pressure reading device is still in development, the engineers fabricating the device need a software solution to aid their development and debugging process along with have a baseline starting point for when the device will be used more extensively in the beta testing phase of the project.
### Main Features
Most features are set up to assist with the development of the physical device associated with this applciation and are not optimized for end user use. Although the foundations and functionality are built into this application and can be easily ported over for end user use.

The main features that were implemented in this application are as follows:
1. Login and user verification process
2. User and Server Account Creation
3. Bluetooth Low Energy Central and Peripheral Connection
4. Bluetooth data collection
5. Sending and Receiving data from the server
6. Delete user
7. Record observations on the server
8. Delete observations
9. Display observations in graphical form to the user
10. Data is exchanged between the application and the user
11. Debug mode

### Developer Quick Start

#### How to build the application

#### Developer Account
In order to build the application with all of its features an Apple Developer account is needed. To purchase an apple developer account please visit developer.apple.com

#### Commands to Build

Git clone (insert repo here)
Git submodule init
Open Xcode Project
Sign in with developer account in Xcode
Click the build button in Xcode, it looks like a play symbol in the top left of Xcode.

#### How to use the application
Debug Mode
Debug Mode Features
The purpose of debug mode is to create a system within the application that is able to assist the hardware developers in their development process. The following features of debug mode are as follows:

#### How to make adjustments

How to launch the Cloud Server
A cloud server can be launched or a localhost server can be made following the directions in this repository: https://github.com/intersystems-community/iris-fhir-template

## Video on how to launch a real cloud server:
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/0HpFLE-mc9Y/0.jpg)](https://youtu.be/0HpFLE-mc9Y)

## Video Tutorial 1:
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/nKJfJYOttMo/0.jpg)](https://youtu.be/nKJfJYOttMo)
1. How to load Xcode
2. Mac Tools
3. How to load the reposittory
4. Information on how the application is organized

## Video Tutorial 2:
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Ne1W1m6fFrc/0.jpg)](https://youtu.be/Ne1W1m6fFrc)

## Video Tutorial 3:
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Ne1W1m6fFrc/0.jpg)](https://youtu.be/Ne1W1m6fFrc)

## Video Demonstration of the Application
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Ne1W1m6fFrc/0.jpg)](https://youtu.be/Ne1W1m6fFrc)

## Known Issues & Future Development

1. Implement SMART OAuth between the server and client
2. Implement proper error handling
3. A logger for logging events
4. Add more user functionality for getting and using data.
5. During very very slow internet connectivity the device may not respond, this is a rare occurance.

## Technical Assistance
If you are seriously working to develop this application and need some assitance you can reach out to the developers. Spencer sms310@pitt.edu or Chris chk124@pitt.edu 

Spencer is currently a M.S.(Professional) in Electrical and Computer Engineering studying in his first year at the University of Pittsburgh. He graduated with his B.S. in Computer Engineering in 2021 from the University of Pittsburgh.

Chris is a senior who is graduating this term with a B.S. in Computer Engineering.

# Open Source Licenses

## License 1: 

There are multiple open source pieces of code that have been used in this project, two of which are under different licenses then what this code is licensed under.
The below MIT License applies to the following files.

1. StaticMemory.swift
2. All files in the folder FHIRResourceAssistance except GlaucomaFHIRServer.swift 

MIT License

Copyright (c) 2019 InterSystems Developer Community

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE

## License 2:
The below License applies to the following files:

All files located in the folder “AppleSignIn”

Copyright (c) 2019 Razeware LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## License 3:
The below License applies to all files not explicitly stated above except the following:

StaticMemory.swift
FHIRResourceAssistance/PatientExtension
FHIRResourceAssistance/ObservationExtension
AppleSignIn/SignInWithApple

BSD 3-Clause License

Copyright (c) 2022, University of Pittsburgh
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


## License 4:
The below License applies to the following files:

All files located in the package ChartView

MIT License

Copyright (c) 2021 Will Dale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
