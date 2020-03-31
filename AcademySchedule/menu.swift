//
//  menu.swift
//  AcademySchedule
//
//  Created by Cecilia Soares on 31/03/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation


func todayDate() -> String {
    //formata a data
    let format = DateFormatter()
    format.dateFormat = "MMM dd,yyy"
    let date = format.string(from: Date())
    return date
}
func menu(){
    let schedule = readJson()
    print ("Bem vindo!\n Hoje é: \(todayDate()) \n 1 - ver programacao do dia \n 2 - ver duracao challenge \n 3 - pesquisar por dia \n 4 - admin")
    if let choice = readLine(){
        //escolhas do menu
        switch choice{
        case "1":
            let calendar = Calendar.current
            //separa o dia de acordo com o calendario atual e transforma em string
            var atualDay = String(calendar.component(.day, from: Date()))
        //arranjar uma forma inteligente de adicionar o 0
            atualDay.count == 1 ? atualDay = "0\(atualDay)": nil
            var atualMonth = String(calendar.component(.month, from: Date()))
            atualMonth.count == 1 ? atualMonth = "0\(atualMonth)": nil
        //arranjar uma forma inteligente de fazer isso
            let foundDate = readDate(date: "\(atualDay)/\(atualMonth)" )
            let result = searchDate(foundDate, schedule)
            print(result)
            talk(this: result)
        case "2":
            print("duracao challenge")
        case "3":
            //pesquisa de acordo com a entrada do usuário
            let input = inputDate()
            let foundDate = readDate(date: input)
            let result = searchDate(foundDate, schedule)
            print(result)
            talk(this: result)
        case "4":
            print("Admin")
        default:
            menu()
            
        }
    }
}