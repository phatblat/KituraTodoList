//
//  main2.swift
//  KituraTodoList
//
//  Created by Ben Chatelain on 6/11/17.
//
//

import Kitura
import SwiftyJSON
import HeliumLogger
import LoggerAPI
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
//setupRoutes( router, todos: todos )

///
/// Listen to port 8090
///
Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()

router.all("/*", middleware: BodyParser())

router.get("/") {
    request, response, next in

    let json = JSON(TodoCollectionArray.serialize(todos.getAll()))

    response.status(.OK).send(json: json)

    next()
}

///
/// Add a to-do list item
///
router.post("/") {
    request, response, next in

    if let body = request.body {

        if let json = body.asJSON {

            let title = json["title"].stringValue
            let order = json["order"].intValue
            let completed = json["completed"].boolValue

            let newItem = todos.add(title: title, order: order, completed: completed)

            let result = JSON(newItem.serialize())

            response.status(.OK).send(json: result)

        }
    } else {
        Log.warning("No body")
        response.status(.badRequest)
    }
    
}

// Enable cross-origin requests

// We will be using an existing front-end JavaScript app that is hosted at http://todobackend.com. Since that app needs to make requests to your backend that’s running on a different domain, we need to enable cross origin requests. To do this, we add to the response headers for every route in our application to return the header Access-Control-Allow-Origin: *. Routing middleware serves this purpose well since we can intercept a request, add these headers, then hand it over to a handler that’s registered for a particular route and method. Note the next() invocation. This is important so that other routing elements can be matched next.
router.all("/*", middleware: AllRemoteOriginMiddleware())

