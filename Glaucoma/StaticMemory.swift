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
///
///
// Some aspects of this code are taken from a piece of code under this license:

///MIT License
///
///Copyright (c) 2019 InterSystems Developer Community
///
///Permission is hereby granted, free of charge, to any person obtaining a copy
///of this software and associated documentation files (the "Software"), to deal
///in the Software without restriction, including without limitation the rights
///to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///copies of the Software, and to permit persons to whom the Software is
///furnished to do so, subject to the following conditions:
///
///The above copyright notice and this permission notice shall be included in all
///copies or substantial portions of the Software.
///
///THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
///SOFTWARE.

// Some code was used from Created by Guillaume Rongier on 12/10/2020.


/* Purpose of this file:
     The purpose of this file is to have an area for the storage and processing of all global like data. It is named StaticMemory because everything in there will be stored in a static context. By putting all of this in it's own object it makes using global data safer and easier to track in a multithreaded application.
     
     All static variables should be private and only be accessed by mutating functions
     
     While not necessary, it is easier for readablity if static variables are accessed via StaticMemory.\(someVariableName)
 */

import Foundation
import FHIR
import CryptoKit

class StaticMemory
{
    static var patient = Patient();
    //Change email address to change debug user
    static var userIdentifier:String = "test7@email"
    static var userHash = ""
    static var isUserInit = false;
    static var server: GlaucomaFHIRServer = GlaucomaFHIRServer(baseURL: URL(string: "http://34.125.229.199:32783/fhir/r4/")!)
    // http://34.125.229.199:32783/fhir/r4/Observation/2889
    // http://34.125.229.199:32783/fhir/r4/metadata
    // http://34.125.229.199:32783/fhir/r4/Patient/1983
    static var observations: [Observation] = [];
    static var observationCount = 0;
    static var srch:FHIRSearch = Observation.search(["patient" : "0"]);
    
    //http://localhost:32783/fhir/r4/Observation?_sort=date&category=vital-signs&patient=2442
    public static func getObservations() -> Array<Observation>
    {
        return observations;
    }
    
    public static func getPatient() -> Patient
    {
        return StaticMemory.patient;
    }
    public static func getServer() -> GlaucomaFHIRServer
    {
        return StaticMemory.server
    }
    
    private static func setInitalizedUser(newPatient: Patient) -> Void
    {
        isUserInit = true;
        StaticMemory.patient = newPatient;
    }
    public static func isUserInitalized() -> Bool
    {
        return isUserInit;
    }
    public static func getUserHash() -> String
    {
        return userHash;
    }
    private static func setUserIdentifier(userIdentifier: String)
    {
        self.userIdentifier = userIdentifier
    }
    
    /* -------------------------------------------------------------------------------------------------- */
    //MARK: Patient-Server Funcs
    /* -------------------------------------------------------------------------------------------------- */
    
    //Initialize User functions are used to either A get the User data from the server or B create a user and then write that to the server.
    
    //For use when the user logs in, based on Apple ID
    public static func InitializeUser(userID: String) -> Void
    {
        setUserIdentifier(userIdentifier: userID)
        _ = StaticMemory.createSecurePatient()
        StaticMemory.syncPatient() { (patient,error) in
            if error == nil {
                isUserInit = true
            }
            else
            {
                isUserInit = false
            }
            return;
        }
    }
    
    //For use when the user does not log in, this will access or create the default account based on the default value of StaticMemory.userIdentifier
    public static func InitializeUser() -> Void
    {
        _ = StaticMemory.createSecurePatient()
        StaticMemory.syncPatient() { (patient,error) in
            if error == nil {
                isUserInit = true
            }
            else
            {
                isUserInit = false
            }
            return;
        }
    }
    
    //creates a patient profile that can be used to acquire the patient on the server, don't trust the name, this isn't secure
    private static func createSecurePatient() -> Patient
    {
        //This should not be stored in the code in the future, more security things will need to be implemented
        let salt:String =
        """
        WRwPPo+ul2g+hMLLozyLA0MLDwI2NcW+6z8Ah3Cmg1qKTuxJS+0ecPIGaa4gS0MD
        7MyrdwkKC+6BLVPV+c2rEc8xLj5bZHKmcnbS1ZmcKIBunlENSuUhIAq80PR6a+XI
        BQ2sADDFEVIZWYLn2lwbEgN35wjsw+KjxN454yJAj1Q2RSZ/1QakEZzClqCGzQRL
        JvwnenSzhf6gXu2/+gLnRC22w0Ba1zdUFjJvu1b+lagXhRE68nSvmUBZ+kQJ+T7V
        4uPINAv5sG7lVXkurmYMZVYWBRv4EI+SDOLTMYczVU9e3Hl47fnalTQxJfBKPI6Q
        405JvzjrSZwLTrSjeoEGhnDfEak9oCC7CNaetIdqpVOWiqfoE2mMjflM2HOLkYTG
        6Ck4+mripiVxVZGIHU3XjfZ6Mqy/sx0/55S8NH18USRCbtQhfNBCGkJfSeURdR/a
        OvotCIuxj+4fysSPNzfdltfgrf5Exta1onwHxdRSL7CklZzo4+Ezh2mKbh5f+6ko
        VuJC7wfGVGqppXYs2BhMdFuVKenFU98BxOMycWS5sHiGEz3td0VmLJ4lvm0URo5d
        CYrwKn7V9g9hbtLfLK34hqVgkAZzM1dfz2u8PVseiKDuF9piJS+dWXL0OOF60zAj
        +oqHNC0tpa0riv2ZB0NgKoefGgc0+MGdno4K1kIBAzVvT2x58nQ0LgQy5kIOlgeF
        u/R6+BYcmZOYFROsWolT9WAKBopKplq/CipbwW8lGa7sz0hpHkj5YJWTR0ROvqE+
        itYM0sWg9lgLq6gWphyjTXFclI4MoNui1LMcqyXWcBpFDkztrIO+pspG8UhumDNi
        """
        
        
        let saltedUser = "\(userIdentifier)\(salt)"
        let inputData = Data(saltedUser.utf8)
        let hashed = SHA256.hash(data:inputData)
        let stringHash = "\(hashed)"
        let trimmedHash = stringHash.split(separator: " ");
        print("\(trimmedHash[2])")
        self.userHash = "\(trimmedHash[2])"
        
        patient.createPatient(firstName: "Patient:", lastName: String(trimmedHash[2]), dateOfBirth: Date(), gender: "Unknown")
        return patient
    }
    
    //Searches for the patient by last name, which in our case is the patient hash
    private static func getPatientByName(completion: @escaping (Patient?, Error?) -> Void ) {
        // search patient on the fhir repository by family name
        Patient.search(["family": "\(StaticMemory.getUserHash())"]).perform(StaticMemory.server) { (bundle, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if let bundleEntry = bundle?.entry?.first,
                let patient = bundleEntry.resource as? Patient {
                // Complete with the patient resource.
                completion(patient, nil)
            } else {
                // No Patient Resource exists for this user.
                completion(nil, nil)
            }
        }
    }
    
    static func syncPatient( completion: @escaping (Patient?, Error?) -> Void ) {
        
        getPatientByName() { (patient,error) in
            
            if patient == nil {
                //Patient does not exist, need to go make a patient. . .
                let newPatient = StaticMemory.createSecurePatient()
                newPatient.create(server, callback: { (error) in
                    if error != nil {
                        completion(patient,error);
                    }
                    else
                    {
                        //Go back to the server again and get that patient so that we can use it
                        StaticMemory.syncPatient() { (patient,error) in
                            print("\(StaticMemory.getUserHash())");
                            return;
                        }
                    }
                })
                
            } else {
                StaticMemory.setInitalizedUser(newPatient: patient!)
                completion(patient,error)
            }
        }
    }
    
    //Deletes the patient data on the server and all observations that are stored locally
    public static func deletePatientForever() -> Bool
    {
        var valueToReturn = false;
        patient._server = server;
        print("Deleteing Patient: \(String(describing: patient.id))")
        patient.delete(callback: { (error) in
            if error == nil {
                valueToReturn = true
            }
            else
            {
                valueToReturn = false
            }
        })
        StaticMemory.deleteAllLocalObservations();
        return valueToReturn
    }
    
    /* -------------------------------------------------------------------------------------------------- */
    //MARK: Observation-Server Funcs
    /* -------------------------------------------------------------------------------------------------- */
    
    public static func getPatientObservations()
    {
        //Get patient information for search
        var patient = StaticMemory.getPatient()
        while patient.id == nil
        {
            patient = StaticMemory.getPatient();
        }
        let patientId = patient.id!
        
        //Clear local observation list
        observations.removeAll()
        srch = Observation.search(["patient" : "\(patientId)"])
        print("About to perform search \(patientId)");

        srch.perform(server) { (bundle, error) in
            var i = bundle?.entry?.count
            if i != nil
            {
                print("We have some observations")
                while i! > 0 {
                    if let bundleEntry = bundle?.entry?.removeFirst(),
                        let observation = bundleEntry.resource as? Observation {
                        observations.append(observation)
                    } else {
                        /* Out of entries, nothing to do */
                    }
                    i = i! - 1;
                }
                print("Getting next page of observatins!")
                StaticMemory.getNextPageOfObservations()
            }
        }
        return;
    }
    
    private static func getNextPageOfObservations() -> Void
    {
        srch.nextPage(server) { (bundle, error) in
            if bundle == nil && error == nil
            {
                /* bundle and error are nil, no more pages found */
            }
            else if bundle == nil
            {
                /* No bundle returned, something went wrong */
            }
            else if error == nil
            {
                /* No Errors, execution is safe */
                var i = bundle?.entry?.count
                if i != nil
                {
                    
                    while i! > 0 {
                        if let bundleEntry = bundle?.entry?.removeFirst(),
                            let observation = bundleEntry.resource as? Observation {
                            observations.append(observation);
                        } else {
                            /* Call complete, you can move onto the next one */
                        }
                        i = i! - 1;
                    }
                }
                //Recursive call to get the next page, this call must be within the nextPage closure so that the calls are serial
                StaticMemory.getNextPageOfObservations();
            }
        }
    }
    
    //loops through observations at prints out their values and Id's
    //FHIR Objects are finickey when printing
    public static func printObservations() -> Void
    {
        
        for observation in observations{
            let obvValue = observation.getValue()
            let obvId = observation.id!
            let dateTime = observation.effectiveDateTime!;
            print("\(obvValue) + \(obvId) + \(dateTime)")
        }
        print("Observation Count = \(observations.count)")
    }
    
    public static func deleteSingleObservation(date: Date, value: Double) -> Bool
    {
        var valueToReturn = false;
        var observationToRemove = Observation();
        var observationIndex = 0;
        var indexToRemove = 0;
        var attemptRemoval = false;
        for observation in observations {
            
            if(date == observation.getDate() && value == Double("\(observation.getValue())")!)
            {
                observationToRemove = observation;
                valueToReturn = observation.deleteWrapper();
                indexToRemove = observationIndex;
                attemptRemoval = true;
            }
            observationIndex = observationIndex + 1;
        }
        if attemptRemoval
        {
            valueToReturn = observationToRemove.deleteWrapper();
            observations.remove(at: indexToRemove);
        }
        return valueToReturn
    }
    
    //Takes all the observations that are currently loaded in the device and asks the server to delete them.
    public static func deleteAllLocalObservations() -> Bool
    {
        var valueToReturn = false;
        patient._server = server;
        
        for observation in observations {
            let thingId = observation.id!
            print("Deleteing Observation: \(thingId)")
            observation.delete(callback: { (error) in
                if error != nil {
                    valueToReturn = false
                }
            })
        }
        observations.removeAll()
        return valueToReturn
    }
}
