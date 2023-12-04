//
//  NetworkModel.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

final class Servicio: Codable{
    var nombre: String
    var headers: Bool
    var auto: Bool?
    var method: String
//    var valores: [Headers]
    var url: String
    
    required init(nombre:String, headers:Bool, method:String, url:String){
        self.nombre = nombre
        self.headers = headers
        self.method = method
        self.url = url
        self.auto = false
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
