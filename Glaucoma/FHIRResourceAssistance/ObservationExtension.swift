//
//  ObservationExtension.swift
//  Glaucoma
//
//  Created by SpencerSullivan on 3/19/22.
//

import Foundation
import FHIR

extension Observation
{
    func CreateIOPObservation(mmHg: Int, patient: Patient)
    {
        let quantity = Quantity();
        quantity.unit = "mmHg"
        quantity.value = FHIRDecimal(integerLiteral: mmHg)
        self.valueQuantity = quantity
        self.category = try! [CodeableConcept(json: [
            "coding": [
              [
                "system": "http://terminology.hl7.org/CodeSystem/observation-category",
                "code": "activity",
                "display": "Activity"
              ]
            ]
        ])]

        self.code = try! CodeableConcept(json: [
            "coding": [
                [
                    "system": "http://loinc.org",
                    "display": "Interocular Pressure",
                    "code": "55423-8"
                ]
            ]
        ])
        let patient = StaticMemory.getPatient()
        let value = patient.id!
        let patientReference = try! Reference(json: ["reference" : "Patient/\(value)"])
        self.subject = patientReference
        let today = Date()
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let seconds = (Calendar.current.component(.second, from: today))
        let hoursInt = UInt8("\(hours)")!;
        print("\(hoursInt) + \(minutes)")
        let observationTime = FHIRTime(hour: UInt8("\(hours)")!, minute: UInt8("\(minutes)")!, second: 0)
        let timeZone = TimeZone(identifier: "EST");
        let fiDate = FHIRDate(string: "\(today)")!;
        let observationDateTime = DateTime(date: fiDate, time: observationTime, timeZone: timeZone)
        self.effectiveDateTime = observationDateTime
        self.status = .final
    }
}


