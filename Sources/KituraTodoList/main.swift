//
//  main.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import KituraTodoListCore

let todoList = KituraTodoList()

do {
    try todoList.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
