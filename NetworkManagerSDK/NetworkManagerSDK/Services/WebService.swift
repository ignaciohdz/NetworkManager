//
//  WebService.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import UIKit
import Foundation

public class WebService {
    ///Notificaciòn de servicio (start / finish)
    public var callbackServices : ((ServicesPlugInResponse) -> Void)?
    
    
    public init (){
        ///Inicializador
    }
    
    /// Función para obtener todos los caracteres de Rick & Morty
    /// - Parameter callback: ObjResponseCharacters (case response) / ErrorResponse (case error)
    public func getCharacters(callback:@escaping CallbackResponseCharacters){
        self.callbackServices?(ServicesPlugInResponse(.start))
        
        let service = Servicio(nombre: "getCharacters", headers: false, url: "https://rickandmortyapi.com/api/character")
        service.printResponse = true
        
        let params = [String:Any]()
        
        Network().methodGet(servicio: service, params: params) { response, failure in
            if let error = failure {
                callback(ObjResponseCharacters(), error)
                return
            }else{
                let decoder = JSONDecoder()
                do {
                    let datos = response!.data!
                    let decodedResponse = try decoder.decode(ObjResponseCharacters.self, from: datos)
                    callback(decodedResponse, nil)
                }catch {
                    print("❌ ERROR Decode: \(error.localizedDescription)")
                    let err:ErrorResponse = ErrorResponse()
                    err.errorMessage = "Error en parseo de datos"
                    callback(ObjResponseCharacters(), err)
                }
            }
            self.callbackServices?(ServicesPlugInResponse(.finish))
        }
    }
}
