//
//  StructsObjects.swift
//  NetworkManagerSDK
//
//  Created by Ignacio Hernandez Montes on 01/12/23.
//

import Foundation

public struct ServicesPlugInResponse {
    public var status: statusService
    
    init() {
        status = .start
    }
    
    init(_ status: statusService) {
        self.status = status
    }
}
