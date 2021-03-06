//
//  search.swift
//  AcademySchedule
//
//  Created by Albert Rayneer on 26/03/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//


import Foundation

enum SearchError: Error {
    case InvalidDate
    case InvalidSchedule
    case InvalidDay
    case InvalidMonth
    case NoEventFound
}


//Procura pela data inserida no calendario e retorna todas as informações sobre ela
func searchDate(_ date: [String:String]?,_ schedule: Schedule?) throws -> [String:Any] {
    
    //Desempacotando todas as variaveis de entrada
    guard let date = date else { throw SearchError.InvalidDate }
    guard let schedule = schedule else { throw SearchError.InvalidSchedule }
    
    guard let stringDay = date["day"] else { throw SearchError.InvalidDay }
    guard let month = date["month"] else { throw SearchError.InvalidMonth }
    let nextMonth = date["nextMonth"] ?? ""
    let day = Int(stringDay)
    
    //filtrar do json o mês inserido e o mês seguinte
    let foundMonths = schedule.months.filter { $0.name == month || $0.name == nextMonth }
    var foundEvent: String = ""
    //Primeiro e ultimo dia do evento
    var firstDay: Int = 0
    var lastDay: Int = 0
    
    //Indica se o evento continua no proximo mês
    var foundNextMonth: Bool = false
    var durationEvent: Int = 0
    //Busca o evento referente a data inserida
    for event in foundMonths[0].events{
        //Filtra se no dia digitado há evento
        if ( event.eventDays.filter { $0 == day } != [] ) {
            let endIndex = event.eventDays.count - 1
            firstDay = event.eventDays[0]
            lastDay = event.eventDays[endIndex]
            foundEvent = event.eventName
            //Soma com a duração do evento
            durationEvent += event.eventDays.count
            break
        } else {
            continue
        }
    }
    
    //Lança um erro se nenhum evento for encontrado
    if foundEvent == "" {
        throw SearchError.NoEventFound
    }
    
    //Verifica se há continuação do evento no mês seguinte
    if foundMonths.count > 1 {
        for event in foundMonths[1].events {
            if event.eventName == foundEvent {
                let endIndex = event.eventDays.count - 1
                //Atribui o ultimo dia do evento do mês seguinte
                lastDay = event.eventDays[endIndex]
                foundNextMonth = true
                //Soma com a duração do evento
                durationEvent += event.eventDays.count
            }
        }
    }
    //Verifica se houve evento no mês seguinte ou não e guarda o mês em uma constante
    let next = foundNextMonth ? nextMonth : month
    
    return ["event": foundEvent,"firstDay": firstDay,"month": month,"lastDay": lastDay,"nextMonth": next,"eventDuration": durationEvent]
    
}
