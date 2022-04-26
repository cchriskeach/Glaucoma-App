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

import Foundation
import SwiftUI

class Today{
    
    let date = Date()
    let dateFormatter = DateFormatter()
    let calendar: Calendar
    
    let weekday: String
    let day: Int
    let month: String
    
    let day_inaweek: String
    let day_inamonth: String
    let month_inamonth: String
    
    init(){
        dateFormatter.dateFormat = "EEEE"
        weekday = dateFormatter.string(from: date)
        
        calendar = Calendar.current
        day = calendar.component(.day, from: date)
        
        dateFormatter.dateFormat = "MMMM"
        month = dateFormatter.string(from: date)
        
        let day_inaweek_Date = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date)
        day_inaweek = String(describing: calendar.component(.day, from: day_inaweek_Date!))
        
        let day_inamonth_Date = Calendar.current.date(byAdding: .weekOfYear, value: 4, to: date)
        day_inamonth = String(describing: calendar.component(.day, from: day_inamonth_Date!))
        month_inamonth = dateFormatter.string(from: day_inamonth_Date!)
    }
    
    func getCurrentTime() -> String{
        let today = "\(weekday), \(month) \(day)".uppercased()
        return today
    }
    
    func getPastWeek() -> String{
        let pastWeek = "\(month) \(day) - \(month) \(day_inaweek)".uppercased()
        return pastWeek
    }
    
    func getNextMonth() -> String{
        let nextMonth = "\(month) \(day) - \(month_inamonth) \(day_inamonth)".uppercased()
        return nextMonth
    }
    
    func loadProfile(){
        //load the profile
    }
}
