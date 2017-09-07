@_exported import Vapor

extension Droplet {
    public func setup() throws {
        try setupPostRoutes()
        try setUpFriendRotes()
        // Do any additional droplet setup
    }
}
