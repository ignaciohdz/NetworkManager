//
//  StructsObjects.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

typealias CallbackCustomResponse = (_ response: customResponseObject?, _ error: NSError?) -> ()

struct customResponseObject{
    var success : Bool = false
    var message : String = ""
}





public typealias CallbackResponseCharacters = (_ response: ObjResponseCharacters?, _ error: NSError?) -> ()


final public class ObjResponseCharacters : Codable{
    public var info : InfoCharacter?
    
    init(){
        self.info = InfoCharacter()
    }
}

final public class InfoCharacter:Codable{
    var count : Int
    var pages : Int
    var next : String?
    var prev : String?
    init(){
        self.count = 0
        self.pages = 0
        self.next = ""
        self.prev = ""
    }
}



