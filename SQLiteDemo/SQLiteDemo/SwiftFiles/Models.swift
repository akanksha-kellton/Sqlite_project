//
//  Models.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 20/07/22.
//

import Foundation

class Details{
     
    var name:String = String()
    var email:String = String()
    var mobile:Int64 = Int64()
    var id: Int = 0
    
    init(id: Int, name:String, email:String, mobile:Int64){
        
        self.id = id
        self.name = name
        self.email = email
        self.mobile = mobile
        
    }
}

