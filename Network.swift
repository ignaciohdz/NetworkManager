//
//  Network.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

struct Network{
    
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
                        completion(customResponseObject(), error)
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
                    objResponse.message = responseJSON["message"] as! String
                    DispatchQueue.main.async {
                        completion(objResponse, nil)
                    }
                }
            }
            task.resume()
        }
}
