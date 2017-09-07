//
//  FriendController.swift
//  Vapor1
//
//  Created by 姜奎 on 2017/8/19.
//
//

import Foundation
import Vapor
import HTTP

/// Here we have a controller that helps facilitate
/// RESTful interactions with our FriendModels table
final class FriendController: ResourceRepresentable {
    /// When users call 'GET' on '/FriendModels'
    /// it should return an index of all available FriendModels
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try FriendModel.all().makeJSON()
    }
    
    /// When consumers call 'FriendModel' on '/FriendModels' with valid JSON
    /// create and save the FriendModel
    func create(_ req: Request) throws -> ResponseRepresentable {
        let FriendModel = try req.friendModel()
        try FriendModel.save()
        return FriendModel
    }
    
    /// When the consumer calls 'GET' on a specific resource, ie:
    /// '/FriendModels/13rd88' we should show that specific FriendModel
    func show(_ req: Request, FriendModel: FriendModel) throws -> ResponseRepresentable {
        return FriendModel
    }
    
    /// When the consumer calls 'DELETE' on a specific resource, ie:
    /// 'FriendModels/l2jd9' we should remove that resource from the database
    func delete(_ req: Request, FriendModel: FriendModel) throws -> ResponseRepresentable {
        try FriendModel.delete()
        return Response(status: .ok)
    }
    
    /// When the consumer calls 'DELETE' on the entire table, ie:
    /// '/FriendModels' we should remove the entire table
    func clear(_ req: Request) throws -> ResponseRepresentable {
        try FriendModel.makeQuery().delete()
        return Response(status: .ok)
    }
    
    /// When the user calls 'PATCH' on a specific resource, we should
    /// update that resource to the new values.
    func update(_ req: Request, FriendModel: FriendModel) throws -> ResponseRepresentable {
        // See `extension FriendModel: Updateable`
        try FriendModel.update(for: req)
        
        // Save an return the updated FriendModel.
        try FriendModel.save()
        return FriendModel
    }
    
    /// When a user calls 'PUT' on a specific resource, we should replace any
    /// values that do not exist in the request with null.
    /// This is equivalent to creating a new FriendModel with the same ID.
    func replace(_ req: Request, FriendModel: FriendModel) throws -> ResponseRepresentable {
        // First attempt to create a new FriendModel from the supplied JSON.
        // If any required fields are missing, this request will be denied.
        let new = try req.friendModel()
        
        // Update the FriendModel with all of the properties from
        // the new FriendModel
        FriendModel.nid = new.nid
        FriendModel.name = new.name
        FriendModel.age = new.age
        FriendModel.email = new.email
        FriendModel.phone = new.phone
        FriendModel.password = new.password
        try FriendModel.save()
        
        // Return the updated FriendModel
        return FriendModel
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<FriendModel> {
        return Resource(
            index: index,
            store: create,
            show: show,
            update: update,
            replace: replace,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    /// Create a FriendModel from the JSON body
    /// return BadRequest error if invalid
    /// or no JSON
    func friendModel() throws -> FriendModel {
        guard let json = json else { throw Abort.badRequest }
        return try FriendModel(json: json)
    }
}

/// Since FriendModelController doesn't require anything to
/// be initialized we can conform it to EmptyInitializable.
///
/// This will allow it to be passed by type.
extension FriendController: EmptyInitializable { }
