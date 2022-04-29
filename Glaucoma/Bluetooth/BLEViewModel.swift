///BSD 3-Clause License
///
///Copyright (c) 2022, University of Pittsburgh
///All rights reserved.
///
///Redistribution and use in source and binary forms, with or without
///modification, are permitted provided that the following conditions are met:
///
///1. Redistributions of source code must retain the above copyright notice, this
///   list of conditions and the following disclaimer.
///
///2. Redistributions in binary form must reproduce the above copyright notice,
///   this list of conditions and the following disclaimer in the documentation
///   and/or other materials provided with the distribution.
///
///3. Neither the name of the copyright holder nor the names of its
///   contributors may be used to endorse or promote products derived from
///   this software without specific prior written permission.
///
///THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
///AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
///IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
///DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
///FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
///DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
///SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
///CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
///OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
///OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import Foundation
import CoreBluetooth

class BLEViewModel: NSObject, ObservableObject{
    
    //BLEFriend UUID
    let BLEFriend = "E76DB972-F9E4-AD27-CF77-2E90668BC6C2"
    

    //UART Service
    let BLEFriendUART = CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
    //Transmitting Characteristic
    let BLEFriendTx = CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
    //Recieving Characteristic
    let BLEFriendRx = CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    
    var Services = [CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")]
    var Characteristics = [CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"), CBUUID(string: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")]
    
    var myCentral: CBCentralManager!
    var myPeripheral: CBPeripheral?
    var myCharacteristics = [CBCharacteristic]()
    
    var BLEon = false
    
    @Published var data: TonometerData?
    @Published var BLEStatus = "No Device Connected"
    
    override init(){
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    //Start Scanning for peripherals
    func startScan(){
        //if BLEon{
            print("Starting Scan")
            self.BLEStatus = "Starting Scan"
            myCentral.scanForPeripherals(withServices: nil, options: nil)
        //}
    }
    
    //Stop scanning for peripherals
    func stopScan(){
        myCentral.stopScan()
        print("Stopping Scan")
        self.BLEStatus = "Stopping Scan"
    }
    
    
    //connect to specified peripheral
    func connect(peripheral: CBPeripheral){
        self.myPeripheral = peripheral
        myCentral.connect(peripheral, options:nil)
    }
    
    //disconnect a specific peripheral
    func disconnect(peripheral: CBPeripheral){
        myCentral.cancelPeripheralConnection(peripheral)
    }
    
    //Call after connecting to peripheral
    func discoverServices(peripheral: CBPeripheral){
        // USE IF YOU DONT KNOW SERVICE UUID
        //peripheral.discoverServices(nil)
        
        peripheral.discoverServices(Services)
        print("Locating Servies...")
        self.BLEStatus = "Locating Services"
    }
    
    //Call after discovering services
    func discoverCharacteristics(peripheral: CBPeripheral){
        guard let services = peripheral.services else{
            return
        }
        for service in services {
            print(service.uuid.uuidString)
            peripheral.discoverCharacteristics(Characteristics, for: service)
        }
    }
    
    //Call to discover descriptors of characteristics
    func discoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic){
        peripheral.discoverDescriptors(for: characteristic)
    }
    
    //Subscribe to notifications
    func subscribeToNotifications(peripheral: CBPeripheral, characteristic: CBCharacteristic){
        peripheral.setNotifyValue(true, for: characteristic)
    }
    
    //READ VALUE from characteristic
    func readValue(characteristic: CBCharacteristic){
        self.myPeripheral?.readValue(for: characteristic)
    }
    
    func writeValue(value: Data, charactersitic: CBCharacteristic){
        self.myPeripheral?.writeValue(value, for: charactersitic, type: .withResponse)
        //OR Change type to .withoutResponse for faster but more errors potentially
    }
}








//EXTENSION
extension BLEViewModel: CBCentralManagerDelegate, CBPeripheralDelegate{
    
    //central bluetooth status
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
            case .poweredOn:
                BLEon = true
                print("Powered on")
                //startScan()
            case .poweredOff:
                print("powered off")
                self.BLEStatus = "Bluetooth Powered Off"
                //stopScan()
            case .unauthorized:
                print("powered on")
                //tell user to give authorization in settings
            case .resetting:
                print("powered on")
                //idk
            case .unsupported:
                print("powered on")
                //this app is not compatible
            case .unknown:
                print("powered on")
                //no idea
            @unknown default:
                print("idk")
        }
    }
    
    //called when new peripheral is discovered
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        
        //USE THIS CODE IF YOU DONT KNOW UUID BUT KNOW LOCAL NAME OK CHRIS GOT IT???
        
//        var peripheralName: String!
//
//        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String{
//            peripheralName = name
//            //print(peripheralName)
//        }else{
//            peripheralName = "Unknown"
//        }
//
//        if peripheralName == "Control"{
//            print(peripheral.identifier.uuidString)
//            connect(peripheral: peripheral)
//        }
        
        
        if peripheral.identifier.uuidString == BLEFriend{
            connect(peripheral: peripheral)
        }

    }
    
    //connection successfull, this is called
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //self.myPeripheral = peripheral
        peripheral.delegate = self
        print("BLE CONNECTED")
        self.BLEStatus = "Device Connected"
        discoverServices(peripheral: peripheral)
    }
    
    //connection failed, this is called
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("ERROR didFailtoConnect \(String(describing: error))")
        self.BLEStatus = "Device Failed to Connect"
    }
    
    //disconnect delegate, this is called
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error{
            print("ERROR didDisconnectPeripheral \(error)")
            self.BLEStatus = "Deviced Failed to Disconnect"
            return
        }
        //successful disconnection
        print("Disconnection Successful you did it chris")
        self.BLEStatus = "Device Disconnected"
    }
    
    //called for every service discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else{
            print("ERROR didDiscoverServices \(String(describing: error))")
            self.BLEStatus = "Failed to Discover Services"
            return
        }
        discoverCharacteristics(peripheral: peripheral)
    }
    
    //called for every characteristic of each service discovered
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else{
            print("ERROR didDiscoverCharacteristics \(String(describing: error))")
            self.BLEStatus = "Failed to Discover Characteristics"
            return
        }
        
        //STORE IMPORTANT CHARACTERISTICS HERE
        //from here, can read/write to characteristics or sub to notificaitons.
        for items in characteristics{
            if (Characteristics.contains(items.uuid)){
                myCharacteristics.append(items)
                
                //automatically subscribe to Rx characteristic
                if items.uuid == Characteristics[1]{
                    print("Found UART Service")
                    print("Identified Authentic Characteristic")
                    self.BLEStatus = "Identified Service"
                    self.BLEStatus = "Identified Authentic Characteristc"
                    subscribeToNotifications(peripheral: myPeripheral!, characteristic: items)
                }
                
            }
        }
    }
    
    //called for every descriptor of each characteristic
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        guard let descriptors = characteristic.descriptors else{
            print("ERROR didUpdateValue \(String(describing: error))")
            self.BLEStatus = "Failed to Discover Descriptor of Characteristic"
            return
        }
        
        //Get user description descriptors
        if let userDescriptionDescriptor = descriptors.first(where: {
            return $0.uuid.uuidString == CBUUIDCharacteristicUserDescriptionString
        }) {
            //Read user description for characteristic
            peripheral.readValue(for: userDescriptionDescriptor)
        }
    }
    
    //called when we write or update the user description
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        //Get and print user description for a given characteristc
        if descriptor.uuid.uuidString == CBUUIDCharacteristicUserDescriptionString,
           let userDescription = descriptor.value as? String{
            print("Characteristic \(String(describing: descriptor.characteristic?.uuid.uuidString)) is also know as \(userDescription)")
        }
    }
    
    //Called when subscribing to notif
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error{
            print("ERROR didUpdateNotificationStatus \(error)")
            self.BLEStatus = "Failed to Subscribe to Notifications"
            return
        }
        //Successfully subscribed to notifs
        print("Successfully subscribed to notifications")
        self.BLEStatus = "Device Connected! Tap to Continue"
    }
    
    //Called when value of characteristic is read
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error{
            print("ERROR didUpdateValue \(error)")
            return
        }
        
        guard error == nil,
            let value = characteristic.value
        else{
            print("ERROR didUpdateValue \(String(describing: error))")
            return
        }
        
        print("Detected incoming data from RX characteristic")
        print("Recieving data from Tonometer")
        print("Updating View..")

        //do something pass to view controller and update a UI color there
        data = TonometerData(value)
        
        //this converts value to a string
//        if let string = String(data: value, encoding: .utf8){
//            print(string)
//        }
    }
    
    //Called when value of characteristc is written
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error{
            print("ERROR didWriteValuefor \(error)")
            return
        }
        //Succesfully wrote value to characteristic!
        print("Data successfully written")
    }
}
