//
//  WebService.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

public class WebService{
    public func getCharacters(callback:@escaping CallbackResponseCharacters){
        let service = Servicio(nombre: "getCharacters", headers: false, method: "GET", url: "https://rickandmortyapi.com/api/character")
        let params = [String:Any]()
        
        Network().methodPost(servicio: service, params: params) { response, error in
            
        }
    }
}
