//
//  TodoCollectionArray.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import Foundation

// https://github.com/IBM-Swift/Kitura-redis
// https://github.com/IBM-Swift/Kitura-CouchDB
private var _collection = [String: TodoItem]()

let writingQueue = DispatchQueue(label: "writingQueue", qos: .userInitiated, attributed: .concurrent)
let semaphore = DispatchSemaphore(value: 1)

func add(title: String, order: Int, completed: Bool) -> TodoItem {

    var original: String
    original = String(self.idCounter)

    let newItem = TodoItem(id: original,
                           order: order,
                           title: title,
                           completed: false,
                           url: self.baseURL + "/" + original
    )

    writingQueue.sync() {

        semaphore.wait()
        self.idCounter+=1
        self._collection[original] = newItem
        semaphore.signal()

    }

    Log.info("Added \(title)")
    
    return newItem
    
}

func delete(id: String) {
    writingQueue.sync() {
        semaphore.wait()
        self._collection.removeValueForKey(id)
        semaphore.signal()
    }
}

static func serialize(items: [TodoItem]) -> [JSONDictionary] {
    return items.map { $0.serialize() }
}


