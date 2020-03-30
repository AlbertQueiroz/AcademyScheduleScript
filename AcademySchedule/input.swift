//
//  input.swift
//  AcademySchedule
//
//  Created by Albert Rayneer on 30/03/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

func inputDate() -> String?{
    var date: String? = nil
    if arguments.count > 1 {
        date = arguments[1]
    } else {
        print("Insira a data para consultar o calendario (DD/MM): ")
        if let inputDate = readLine() {
            date = inputDate
        }
    }
    return date
}

func readDate(date: String?) -> [String:String]? {

    guard let date = date else {return nil}
    
    let splitedDate = date.split{$0 == "/"}

    let day: String = String(splitedDate[0])
    var month: String = String(splitedDate[1])

    switch month {
        case "02": month = "fevereiro"
        case "03": month = "março"
        case "04": month = "abril"
        case "05": month = "maio"
        case "06": month = "junho"
        default: return nil
    }
    
    let dateDict = ["day": day, "month": month]

    return dateDict
}
