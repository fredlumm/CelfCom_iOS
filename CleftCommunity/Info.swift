//
//  Info.swift
//  CleftCommunity
//
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import Foundation
import UIKit

var myInfo: UserInfo = UserInfo()
var myPost: Thread = Thread()
var friends = [UserInfo]()
var threads = [Thread]()
var qas = [Q_A]()
var likeComments = [String]()

class UserInfo: NSObject{
    var photo: NSData!
    var nickname: String = ""
    var ID: String = ""
    var gender: String = ""
    var age: String = ""
    var region: String = ""
    var email: String = ""
    var phone: String = ""
    var motto: String = ""
    override init() {
        super.init()
    }
    init(_nickname: String, _ID: String, _age: String, _gender: String, _region: String, _email: String, _phone: String, _motto: String, _photo: NSData) {
        self.photo = _photo
        self.nickname = _nickname
        self.ID = _ID
        self.age = _age
        self.gender = _gender
        self.region = _region
        self.email = _email
        self.phone = _phone
        self.motto = _motto
    }
}

class Thread: NSObject{
    var tID: String = ""
    var title: String = ""
    var author: String = ""
    var authorID: String = ""
    var time: String = ""
    var pic: NSData!
    var text: String = ""
    var commentNum = 0
    override init() {
        super.init()
        let newimage = UIImage(named:"love.jpg")
        let imageData = UIImageJPEGRepresentation(newimage!, 1.0)
        pic = imageData
    }
}

class Comment: NSObject{
    var text: String = ""
    var name: String = ""
    var ID: String = ""
    var tID: String = ""
    var likeNum = 0
    var photo:NSData!
    var OID: String = ""
    override init() {
        super.init()
        let newimage = UIImage(named:"initial.jpg")
        let imageData = UIImageJPEGRepresentation(newimage!, 1.0)
        photo = imageData
    }
    
}

class Q_A: NSObject{
    var Ques: String = ""
    var Ans: String = ""
    override init() {
        super.init()
    }
}