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
/////
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
        let observationTime = FHIRTime(hour: UInt8("\(hours)")!, minute: UInt8("\(minutes)")!, second: 0)
        let timeZone = TimeZone(abbreviation: "EST");
        let fiDate = FHIRDate(string: "\(today)")!;
        let observationDateTime = DateTime(date: fiDate, time: observationTime, timeZone: timeZone)
        self.effectiveDateTime = observationDateTime
        self.status = .final
    }
    func getValue() -> Int
    {
        return Int("\(self.valueQuantity?.value! ?? -1)")!
    }
    
    func getDateTime() -> DateTime
    {
        return self.effectiveDateTime!
    }
    
    func getDate() -> Date
    {
        let isoDate = "\(self.effectiveDateTime!)"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: isoDate)!
    }
    
}


