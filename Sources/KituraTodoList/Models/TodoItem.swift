//
//  TodoItem.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import Foundation

struct TodoItem {
    var id: String
    var order: Int
    var title: String
    var completed: Bool
    var url: String

    init(id: String = "", order: Int = 0, title: String = "", completed: Bool = false,
                url: String = "") {
        self.id = id
        self.order = order
        self.title = title
        self.completed = completed
        self.url = url
    }

    func serialize() -> JSONDictionary {
        var result = JSONDictionary()
        result["id"] = id
        result["order"] = order
        result["title"] = title
        result["completed"] = completed
        result["url"] = url
        return result
    }
}
