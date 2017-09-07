import Vapor

extension Droplet {
    func setupPostRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }
        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
extension Droplet {
    func setUpFriendRotes() throws {
        // MARK: - 1 登录
        self.get("friend.login") { (req) -> ResponseRepresentable in
            var json = JSON()
            
            guard let name = req.data["name"]?.string else{
            throw Abort.badRequest
            }
            guard let password = req.data["password"]?.string else{
                throw Abort.badRequest
            }
//            let postgresqlDriver = try self.postgresql()
//            let friend1 = try postgresqlDriver.master.makeConnection().execute("SELECT name FROM friend_models WHERE name='"+name+"'").array?.first
            
            let friend = try FriendModel.makeQuery().filter( "name", name).first()

            guard friend != nil  else{
            
                try json.set("msg", "此账号尚未注册")
                try json.set("code", "302")
                return json
            
            }
            guard friend?.password == password else {

                try json.set("msg", "密码错误")
                try json.set("code", "302")
                return json
            }
            return try JSON(node: ["friend":friend])
        
        
        }
        // MARK: - 2 注册
        self.get("friend.register") { (req) -> ResponseRepresentable in
            var json = JSON()
            guard let name = req.data["name"]?.string else{
                
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let pwd = req.data["password"]?.string else {
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard ((try FriendModel.makeQuery().filter("name",name).first()) == nil) else{
                try json.set("msg", "用户名已注册")
                try json.set("code", "302")
                return json
            }
            let nid = name+pwd+Date.init().description
            let fri = FriendModel(nid:nid, name: name, age: Int.init(), email: String.init(), phone: Int.init(), password: pwd ,headPortrait: String.init())
            
            try fri.save()
            try json.set("msg", "注册成功")
            try json.set("code","200")
            return try JSON(node: ["data":fri])
        }
        
        // MARK: - 3 修改密码
        self.get("friend.modifypassword") { (req) -> ResponseRepresentable in
            var json = JSON()
            guard let nid = req.data["nid"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let oldPwd = req.data["oldpassword"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let newPwd = req.data["newpassword"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let friend = try FriendModel.makeQuery().filter("nid",nid).first() else{
                try json.set("msg", "此账号尚未注册")
                try json.set("code", "302")
                return json
            }
            
            
            guard friend.password == oldPwd else{
                try json.set("msg", "旧密码错误")
                try json.set("code", "302")
                return json
            }
            guard oldPwd != oldPwd else{
                try json.set("msg", "新密码和旧密码不能相同")
                try json.set("code", "302")
                return json
            }
            friend.password = newPwd
            try friend.save()
            try json.set("msg", "密码修改成功")
            try json.set("code", "200")
            return json
            
        }
        // MARK: - 4 修改资料
        self.get("friend.fillAccount") { (req) -> ResponseRepresentable in
            var json = JSON()
            guard let nid = req.data["nid"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let friend = try FriendModel.makeQuery().filter("nid",nid).first() else{
                try json.set("msg", "此账号尚未注册")
                try json.set("code", "302")
                return json
            }
            guard let name = req.data["name"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let age = req.data["age"]?.int else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let email = req.data["email"]?.string else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            guard let phone = req.data["phone"]?.int else{
                try json.set("msg", "参数不全")
                try json.set("code", "301")
                return json
            }
            friend.name = name
            friend.age = age
            friend.email = email
            friend.phone = phone
            
            try friend.save()
            try json.set("msg", "修改成功")
            try json.set("code", "200")
            return json
            
        }
        
        
        try resource("friends", FriendController.self)
        
    }
}
