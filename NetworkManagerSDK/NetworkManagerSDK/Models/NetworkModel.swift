//
//  NetworkModel.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

final class Servicio: Codable{
    var nombre:String
    var headers:Bool
    var auto:Bool?
//    var method:String
//    var valores: [Headers]
    var url:String
    var printResponse:Bool
    
    required init(nombre:String, headers:Bool, url:String){
        self.nombre = nombre
        self.headers = headers
        self.url = url
        self.auto = false
        self.printResponse = false
    }
}

final class Headers: Codable{
    var nombre: String
    var valor: String
    
    required init( nombre:String, valor:String ){
        self.nombre = nombre
        self.valor = valor
    }
}


typealias CallbackCustomResponse = (_ response: customResponseObject?, _ failure: ErrorResponse?) -> ()

struct customResponseObject{
    var success:Bool = false
    var data:Data?
}

public class ErrorResponse: Codable, Error {
    public var error: Int
    public var errorMessage: String
    
    enum CodingKeys: Int, CodingKey {
        case error
        case errorMessage
    }
    
    init() {
        error = 0
        errorMessage = ""
    }
}
