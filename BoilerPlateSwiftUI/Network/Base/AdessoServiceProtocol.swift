//
//  AdessoServiceProtocol.swift
//  BoilerPlateSwiftUI
//
//  Created by Saglam, Fatih on 11.01.2023.
//  Copyright © 2023 Adesso Turkey. All rights reserved.
//

import Foundation

protocol AdessoServiceProtocol {
    associatedtype Endpoint: TargetEndpointProtocol

    var baseService: BaseServiceProtocol { get }

    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> Result<T, AdessoError>
    func authenticatedRequest<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> Result<T, AdessoError>
}

extension AdessoServiceProtocol {

    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> Result<T, AdessoError> {
        await baseService.request(with: requestObject, responseModel: responseModel)
    }
    
    func build(endpoint: Endpoint) -> String {
        endpoint.path
    }
    
    func authenticatedRequest<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> Result<T, AdessoError> {
        var requestObject = requestObject
        return await baseService.request(with: prepareAuthenticatedRequest(with: requestObject), responseModel: responseModel)
    }
    
    private func prepareAuthenticatedRequest(with requestObject: RequestObject) -> RequestObject {
        #warning("This does not return an authenticated request")
        //TODO: - how to handle authenticatedRequest with urlSession

        return requestObject
    }
}
