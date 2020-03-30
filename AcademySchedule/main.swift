#!/usr/bin/swift

//
//  main.swift
//  AcademySchedule
//
//  Created by Albert Rayneer on 12/03/20.
//  Copyright © 2020 Albert Rayneer. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

var schedule = readJson()

let input = inputDate()

let foundDate = readDate(date: input)

let result = searchDate(foundDate, schedule)

print(result)
talk(this: result)
