//
//  PatientExtension.swift
//  Glaucoma
//
//  Created by SpencerSullivan on 3/19/22.
//

import Foundation
import FHIR

extension Patient
{
    func createPatient(firstName: String, lastName: String, dateOfBirth: Date, gender: String)
    {
        //Patient.HumanName.family
        let humanName = HumanName()
        humanName.given = [FHIRString(firstName)]
        humanName.family = FHIRString(lastName)
        
        self.name = [humanName]
        self.birthDate = dateOfBirth.fhir_asDate()
        self.gender = AdministrativeGender(rawValue: gender)
        
    }
    
    func getPatient() -> Patient
    {
        return self;
    }
    
    func getId() -> FHIRString
    {
        return self.id ?? FHIRString("0");
    }
}
