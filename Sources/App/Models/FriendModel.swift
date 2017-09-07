//
//  FriendModel.swift
//  Vapor1
//
//  Created by 姜奎 on 2017/8/19.
//
//

import Foundation
import FluentProvider
import HTTP
final class FriendModel : Model{
let storage = Storage()
    static let nidKey = "nid"
    static let nameKey = "name"
    static let ageKey = "age"
    static let emailKey = "email"
    static let phoneKey = "phone"
    static let passwordKey = "password"
    static let headPortraitKey = "headPortrait"
    var nid : String
    var name : String
    var age : Int
    var email : String
    var phone : Int
    var password : String
    var headPortrait : String
    

    
    init(nid: String,name: String,age: Int,email: String,phone: Int,password: String ,headPortrait: String) {
        self.nid = nid
        self.name = name
        self.age = age
        self.email = email
        self.phone = phone
        self.password = password
        self.headPortrait = headPortrait
        
    }
    
    
    // MARK: Fluent Serialization
    
    /// Initializes the FriendModel from the
    /// database row
    init(row: Row) throws {
        nid = try row.get(FriendModel.nidKey)
        name = try row.get(FriendModel.nameKey)
        age = try row.get(FriendModel.ageKey)
        email = try row.get(FriendModel.emailKey)
        phone = try row.get(FriendModel.phoneKey)
        password = try row.get(FriendModel.passwordKey)
        headPortrait = try row.get(FriendModel.headPortraitKey)
    }
    
    // Serializes the FriendModel to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(FriendModel.nidKey, nid)
        try row.set(FriendModel.nameKey, name)
        try row.set(FriendModel.ageKey, age)
        try row.set(FriendModel.emailKey, email)
        try row.set(FriendModel.phoneKey, phone)
        try row.set(FriendModel.passwordKey, password)
        try row.set(FriendModel.headPortraitKey, headPortrait)
        return row
    }

}
// MARK: Fluent Preparation

extension FriendModel: Preparation {
    /// Prepares a table/collection in the database
    /// for storing FriendModels
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(FriendModel.nidKey)
            builder.string(FriendModel.nameKey)
            builder.int(FriendModel.ageKey)
            builder.string(FriendModel.emailKey)
            builder.int(FriendModel.phoneKey)
            builder.string(FriendModel.passwordKey)
            builder.string(FriendModel.headPortraitKey)
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new FriendModel (FriendModel /FriendModels)
//     - Fetching a FriendModel (GET /FriendModels, GET /FriendModels/:id)
//
extension FriendModel: JSONConvertible {
    convenience init(json: JSON) throws {
        
        try self.init(nid: json.get(FriendModel.nidKey), name: json.get(FriendModel.nameKey), age: json.get(FriendModel.ageKey), email: json.get(FriendModel.emailKey), phone: json.get(FriendModel.phoneKey), password: json.get(FriendModel.passwordKey),headPortrait: json.get(FriendModel.headPortraitKey))
    
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(FriendModel.nidKey, nid)
        try json.set(FriendModel.nameKey, name)
        try json.set(FriendModel.ageKey, age)
        try json.set(FriendModel.emailKey, email)
        try json.set(FriendModel.phoneKey, phone)
        try json.set(FriendModel.passwordKey, password)
        try json.set(FriendModel.headPortraitKey, headPortrait)
        return json
    }
}

// MARK: HTTP

// This allows FriendModel models to be returned
// directly in route closures
extension FriendModel: ResponseRepresentable { }

// MARK: Update

// This allows the FriendModel model to be updated
// dynamically by the request.
extension FriendModel: Updateable {
    // Updateable keys are called when `FriendModel.update(for: req)` is called.
    // Add as many updateable keys as you like here.
    public static var updateableKeys: [UpdateableKey<FriendModel>] {
        return [
            // If the request contains a String at key "content"
            // the setter callback will be called.
            UpdateableKey(FriendModel.nidKey, String.self) { FriendModel, nid in
                FriendModel.nid = nid
            },
            UpdateableKey(FriendModel.nameKey, String.self) { FriendModel, name in
                FriendModel.name = name
            },
            UpdateableKey(FriendModel.ageKey, Int.self) { FriendModel, age in
                FriendModel.age = age
            },
            UpdateableKey(FriendModel.emailKey, String.self) { FriendModel, email in
                FriendModel.email = email
            },
            UpdateableKey(FriendModel.phoneKey, Int.self) { FriendModel, phone in
                FriendModel.phone = phone
            },
            UpdateableKey(FriendModel.passwordKey, String.self) { FriendModel, password in
                FriendModel.password = password
            },
            UpdateableKey(FriendModel.headPortraitKey, String.self) { FriendModel, headPortrait in
                FriendModel.headPortrait = headPortrait
            }
            
        ]
    }
}
