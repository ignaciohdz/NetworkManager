//
//  CharactersModel.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 05/12/23.
//

import Foundation

//MARK: - typealias
public typealias CallbackResponseCharacters = (_ response: ObjResponseCharacters?, _ error: ErrorResponse?) -> ()
public typealias CallbackResponseSpecificCharacter = (_ response: ResultCharacter?, _ error: ErrorResponse?) -> ()


//MARK: - Objetos Codable
final public class ObjResponseCharacters : Codable{
    public var info : InfoCharacter?
    public var results : [ResultCharacter]?
    
    init(){
        self.info = InfoCharacter()
        self.results = [ResultCharacter()]
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

final public class ResultCharacter:Codable{
    public var id : Int
    public var name : String
    public var status : String
    public var species : String
    public var type : String
    public var gender : String
    public var origin : originObj
    public var location : locationObj
    public var image : String
    public var episode : [String]
    public var url : String
    public var created : String
    
    init(){
        self.id = 0
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
        self.origin = originObj()
        self.location = locationObj()
        self.image = ""
        self.episode = []
        self.url = ""
        self.created = ""
    }
}


final public class locationObj:Codable{
    public var name : String?
    public var url : String?
    init(){
        self.name = ""
        self.url = ""
    }
}

final public class originObj:Codable{
    public var name : String?
    public var url : String?
    init(){
        self.name = ""
        self.url = ""
    }
}
