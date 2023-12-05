//
//  WebService.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import UIKit
import Foundation

/// WebService implementa las funciones para las llamadas a servicios
/// Una instancia de esta clase te dará acceso a los datos de la API Rick & Morty
public class WebService {
    ///Notificación de estatus de llamada a servicio (start / finish)
    public var callbackServices : ((ServicesPlugInResponse) -> Void)?
    
    
    public init (){
        ///Inicializador
    }
    
    
    /// Función para obtener los personajes de la API Rick & Morty.
    /// En caso de querer obtenerlos todos, el resultado es por pàgina con 20 elementos c/u
    /// ```
    /// self.getCharacters { response, error in }
    /// self.getCharacters(numberPage: 2, callback: { response, error in }
    /// ```
    /// > Warning: El parámetro ``numberPage``
    /// > es opcional y  se mandan para obtener la informaciòn de la pàgina siguiente
    /// 
    /// - Parameters:
    ///   - numberPage: (Opcional) - Nùmero de página a mostrar
    ///   - callback: ObjResponseCharacters (⎷ response) / ErrorResponse (⌀ error)
    public func getCharacters(numberPage:Int? = 0 ,callback:@escaping CallbackResponseCharacters){
        self.callbackServices?(ServicesPlugInResponse(.start))
        
        var urlStr:String = Service.GetCharacters.URL_BASE
        if numberPage! > 0 {
            urlStr += "/?page=\(numberPage!)"
        }
        
        let service = Servicio(nombre: Service.GetCharacters.NAME, headers: false, url: urlStr)
//        service.printResponse = true
        
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
                    callback(ObjResponseCharacters(), self.errorParse(error: error))
                }
            }
            self.callbackServices?(ServicesPlugInResponse(.finish))
        }
    }
    
    /// Función para obtener un personaje especìfico de la API Rick & Morty.
    /// ```
    /// self.getSingleCharacter(characterId: 2) { response, error in }
    /// ```
    /// > Warning: El parámetro ``characterId`` se puede obtener de getCharacters
    ///
    /// - Parameters:
    ///   - characterId: Identificador del personaje
    ///   - callback: ResultCharacter (⎷ response) / ErrorResponse (⌀ error)
    public func getSingleCharacter(characterId:Int ,callback:@escaping CallbackResponseSpecificCharacter){
        self.callbackServices?(ServicesPlugInResponse(.start))
        var urlStr:String = "\(Service.GetCharacters.URL_BASE)/\(characterId)"
        
        let service = Servicio(nombre: Service.GetCharacters.NAME, headers: false, url: urlStr)
        service.printResponse = true
        
        let params = [String:Any]()
        
        Network().methodGet(servicio: service, params: params) { response, failure in
            if let error = failure {
                callback(ResultCharacter(), error)
                return
            }else{
                let decoder = JSONDecoder()
                do {
                    let datos = response!.data!
                    let decodedResponse = try decoder.decode(ResultCharacter.self, from: datos)
                    callback(decodedResponse, nil)
                }catch {
                    callback(ResultCharacter(), self.errorParse(error: error))
                }
            }
            self.callbackServices?(ServicesPlugInResponse(.finish))
        }
    }
    
    
    /// Error para identificar mal paseo de datos
    /// - Parameter error: Error general de respuesta
    /// - Returns: ErrorResponse con mensaje custom
    private func errorParse(error:Error) -> ErrorResponse{
        print("❌ ERROR Decode: \(error.localizedDescription)")
        let err:ErrorResponse = ErrorResponse()
        err.errorMessage = "Error en parseo de datos"
        return err
    }
}
