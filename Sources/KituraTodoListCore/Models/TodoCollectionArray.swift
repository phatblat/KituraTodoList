//
//  TodoCollectionArray.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import HeliumLogger
import LoggerAPI
import Foundation

class TodoCollectionArray {
    // https://github.com/IBM-Swift/Kitura-redis
    // https://github.com/IBM-Swift/Kitura-CouchDB
    fileprivate var _collection = [String: TodoItem]()

    let writingQueue = DispatchQueue(label: "writingQueue", qos: .userInitiated, attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)

    let baseURL: String = ""
    var idCounter: Int = 0

    init() {
        HeliumLogger.use()
    }
}

// MARK: - TodoCollection
extension TodoCollectionArray: TodoCollection {

    static func serialize(_ items: [TodoItem]) -> [JSONDictionary] {
        return items.map { $0.serialize() }
    }

    var count: Int {
        return _collection.count
    }

    func clear() {
        _collection = [:]
    }

    func getAll() -> [TodoItem] {
        return _collection.map { return $0.1 }
    }

    func add(title: String, order: Int, completed: Bool) -> TodoItem {

        var original: String
        original = String(idCounter)

        let newItem = TodoItem(id: original,
                               order: order,
                               title: title,
                               completed: false,
                               url: baseURL + "/" + original
        )

        writingQueue.sync() {

            semaphore.wait()
            idCounter += 1
            _collection[original] = newItem
            semaphore.signal()

        }

        Log.info("Added \(title)")
        
        return newItem
        
    }

    func update(id: String, title: String?, order: Int?, completed: Bool?) -> TodoItem? {
        var item: TodoItem?
        writingQueue.sync() {
            semaphore.wait()
            item = _collection[id]
            item?.title = title!
            item?.order = order!
            semaphore.signal()
        }

        return item
    }

    func delete(id: String) {
        writingQueue.sync() {
            semaphore.wait()
            _collection.removeValue(forKey: id)
            semaphore.signal()
        }
    }

}
