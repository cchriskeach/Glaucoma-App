//
//  Date.swift
//  Glaucoma
//
//  Created by Christopher Keach on 4/1/22.
//

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
