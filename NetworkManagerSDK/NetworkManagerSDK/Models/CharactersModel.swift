//
//  CharactersModel.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 05/12/23.
//

import Foundation

public typealias CallbackResponseCharacters = (_ response: ObjResponseCharacters?, _ error: ErrorResponse?) -> ()

final public class ObjResponseCharacters : Codable{
    public var info : InfoCharacter?
    
    init(){
        self.info = InfoCharacter()
    }
}

final public class InfoCharacter:Codable{
    public var count : Int
    public var pages : Int
    public var next : String?
    public var prev : String?
    init(){
        self.count = 0
        self.pages = 0
        self.next = ""
        self.prev = ""
    }
}
