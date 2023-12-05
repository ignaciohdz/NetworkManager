//
//  Network.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

/// Estructura con métodos GET y POST para llamadas a servicios
struct Network{
    /// Función genérica para peticion de servicios con método "GET"
    /// - Parameters:
    ///   - servicio: Objeto tipo Servicio
    ///   - params: Diccionario de paràmetros
    ///   - completion: customResponseObject (case response) / NSError (case failure)
    func methodGet(servicio:Servicio, params:Dictionary<String, Any>, completion:@escaping CallbackCustomResponse){
        let url = URL(string: servicio.url)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print("❌ Error en servicio \(servicio.nombre)")
                let err:ErrorResponse = ErrorResponse()
                switch error {
                case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet: //showOffline
                    err.error = error.code
                    err.errorMessage = error.localizedDescription
                    completion(customResponseObject(), err)
                case .some(let error as NSError): //showGenericError
                    completion(customResponseObject(), err)
                    err.error = error.code
                    err.errorMessage = error.localizedDescription
                case .none:
                    completion(customResponseObject(), nil)
                }
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            print("✅ Responde el servicio \(servicio.nombre)")
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                DispatchQueue.main.async {
                    if servicio.printResponse{
                        print("RESPONSE:\n\(responseJSON)")
                    }
                    var objResponse = customResponseObject()
                    objResponse.success = (responseJSON["success"] != nil)
                    objResponse.data = data
                    completion(objResponse, nil)
                }
            }
        }
        task.resume()
    }
    
    
    func methodPost(servicio:Servicio, params:Dictionary<String, Any>, completion:@escaping CallbackCustomResponse){
        let url = URL(string: servicio.url)!
        
        let bodyDict = params
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyDict)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

//            for newheader in servicio.valores{
//    //            newHeaders[newheader.nombre] = newheader.valor
//                request.setValue( newheader.valor, forHTTPHeaderField: "Authorization")
//            }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                let error = NSError(domain: "", code: 0,userInfo: [NSLocalizedDescriptionKey: "message"])
                DispatchQueue.main.async {
                    let err:ErrorResponse = ErrorResponse()
                    completion(customResponseObject(), err)
                }
                return
            }
            
//                guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
//                    DispatchQueue.main.async {
//                        let err = NSError()
//                        completion(customResponseObject(), err)
//                    }
//                    return
//                }
            
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                var objResponse = customResponseObject()
                objResponse.success = (responseJSON["success"] != nil)
//                    objResponse.message = responseJSON["message"] as! String
                DispatchQueue.main.async {
                    completion(objResponse, nil)
                }
            }
        }
        task.resume()
    }
    
}
