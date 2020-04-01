//
//  results.swift
//  AcademySchedule
//
//  Created by Albert Rayneer on 31/03/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

let schedule = readJson()

func showResult(date: [String:String]?) {
    
    do{
        let result = try searchDate(date, schedule)
        let stringResult = "Ocorrerá \(result["event"]!) que irá durar \(result["eventDuration"]!) dias, começando no dia \(result["firstDay"]!) de \(result["month"]!) e terminando no dia \(result["lastDay"]!) de \(result["nextMonth"]!)"
        print(stringResult)
        talk(this: stringResult)
    } catch {
      print(error)
    }
    
}
//pega o mês atual de acordo com o calendário e lista os eventos do mês
func monthEvents() throws {
    let calendar = Calendar.current
    let currentMonth = String(calendar.component(.month, from: Date()))
    let monthName = convertMonth(month: currentMonth)
    
    guard let month = (schedule?.months.filter { $0.name == monthName }[0]) else { throw SearchError.InvalidMonth }
    
    print("O que acontecerá nesse mês:")
    for event in month.events{
        print(event.eventName)
    }
    
}
