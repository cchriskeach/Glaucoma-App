//
//  StaticMemory.swift
//  SwiftSMART
//
//  Created by SpencerSullivan on 3/24/22.
//  Copyright © 2022 SMART Health IT. All rights reserved.
//

import Foundation
import FHIR
import CryptoKit

class StaticMemory
{
    static var patient = Patient();
    static var userIdentifier:String = "test3@email"
    static var userHash = ""
    static var isUserInit = false;
    static var server: GlaucomaFHIRServer = GlaucomaFHIRServer(baseURL: URL(string: "http://34.125.229.199:32783/fhir/r4/")!)
    //http://localhost:32783/fhir/r4/Observation/2889
    // http://34.125.229.199:32783/fhir/r4/metadata
    // http://34.125.229.199:32783/fhir/r4/Patient/1983
    static var observations: [Observation] = [];
    static var observationCount = 0;
    static var srch:FHIRSearch = Observation.search(["patient" : "0"]);
    
    //http://localhost:32783/fhir/r4/Observation?_sort=date&category=vital-signs&patient=2442
    public static func getPatientObservations()
    {
        //Get patient information for search
        let patient = StaticMemory.getPatient()
        let patientId = patient.id!
        //Clear local observation list
        observations.removeAll()
        srch = Observation.search(["patient" : "\(patientId)"])

        srch.perform(server) { (bundle, error) in
            var i = bundle?.entry?.count
            if i != nil
            {
                while i! > 0 {
                    if let bundleEntry = bundle?.entry?.removeFirst(),
                        let observation = bundleEntry.resource as? Observation {
                        observations.append(observation);
                    } else {
                        /* Out of entries, nothing to do */
                    }
                    i = i! - 1;
                }
                StaticMemory.getNextPageOfObservations()
            }
        }
        return;
    }
    
    public static func getNextPageOfObservations() -> Void
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
                StaticMemory.getNextPageOfObservations();
            }
        }
    }
    
    public static func printObservations() -> Void
    {
        var i = 0;
        for observation in observations{
            let thing = observation.valueQuantity?.value!
            let thingId = observation.id!
            print("\(thing) + \(thingId)")
            i+=1;
        }
        print(i)
    }
    
    public static func getPatient() -> Patient
    {
        return patient;
    }
    public static func getServer() -> GlaucomaFHIRServer
    {
        return server
    }
    
    public static func setInitalizedUser(newPatient: Patient) -> Void
    {
        isUserInit = true;
        patient = newPatient;
    }
    public static func isUserInitalized() -> Bool
    {
        return isUserInit;
    }
    
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
        return valueToReturn
    }
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
        return valueToReturn
    }
    
    private static func setUserIdentifier(userIdentifier: String)
    {
        self.userIdentifier = userIdentifier
    }
    
    public static func InitializeUser(userID: String) -> Void
    {
        setUserIdentifier(userIdentifier: userID)
        StaticMemory.createSecurePatient()
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
    
    public static func InitializeUser() -> Void
    {
        StaticMemory.createSecurePatient()
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
    
    //creates a patient profile that can be used to acquire the patient on the server
    private static func createSecurePatient() -> Patient
    {
        
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
    
    static func getUserHash() -> String
    {
        return userHash;
    }
    
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
    
    //1 check to see if there is a key generated with the proper tag
    //if not, generate a key, this is likely the first time the user is logging in, this key will then be stored in their keychain
    
    static func getEncryptionKey(email: String) throws -> SecKey
    {
        let tag = "\(email).Glaucoma.keys.mykey".data(using: .utf8)!
        let attributes: [String: Any] =
            [kSecAttrKeyType as String:            kSecAttrKeyTypeRSA,
             kSecAttrKeySizeInBits as String:      2048,
             kSecPrivateKeyAttrs as String:
                [kSecAttrIsPermanent as String:    true,
                 kSecAttrApplicationTag as String: tag]
        ]
        
        //generate query for getting a key if one has already been generated.
        let getquery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                       kSecReturnRef as String: true]
        
        
        //execute query to see if that key existed
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        if(status == errSecSuccess)
        {
            // no error, do nothing
        }
        else
        {
            // There was an error, key must not exist, create the key.
            var error: Unmanaged<CFError>?
            guard SecKeyCreateRandomKey(attributes as CFDictionary, &error) != nil else {
                throw error!.takeRetainedValue() as Error
            }
            
            //key now exists, go get the key
            let status = SecItemCopyMatching(getquery as CFDictionary, &item)
            if (status == errSecSuccess)
            {
                
            }
            else
            {
                print("ERROR")
                throw EncryptionError.empty
                
            }
        }
        
        let patientPrivateKey = item as! SecKey
        
        // return key, use it to generate a fake, yet repeatable patient name
        return patientPrivateKey
    }
    
    enum EncryptionError: Error {
        case empty
        case short
    }
    
}
