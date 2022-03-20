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
        let patientReference = try! Reference(json: ["reference" : "Patient/497"])
        self.subject = patientReference
        self.status = .final
    }
}


