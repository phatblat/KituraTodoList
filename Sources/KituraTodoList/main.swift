//
//  main2.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import Kitura
import Foundation

///
/// The Kitura router
///
public let router = Router()

///
/// Setup the database
///
let todos: TodoCollection = TodoCollectionArray()

///
/// Call a helper function to create routes in App.swift
///
setupRoutes( router, todos: todos )

///
/// Listen to port 8090
///
Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()

router.use("/*", middleware: BodyParser())

router.get("/") {
    request, response, next in

    let json = JSON(TodoCollectionArray.serialize(todos.getAll()))

    response.status(HttpStatusCode.OK).sendJson(json)

    next()
}

///
/// Add a to-do list item
///
router.post("/") {
    request, response, next in

    if let body = request.body {

        if let json = body.asJson() {

            let title = json["title"].stringValue
            let order = json["order"].intValue
            let completed = json["completed"].boolValue

            let newItem = todos.add(title, order: order, completed: completed)

            let result = JSON(newItem.serialize())

            response.status(.OK).sendJSON(result)

        }
    } else {
        Log.warning("No body")
        response.status(.badRequest)
    }
    
}
