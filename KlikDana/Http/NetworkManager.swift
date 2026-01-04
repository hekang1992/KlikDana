//
//  NetworkManager.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
}

extension NetworkManager {
    
    func get<T: Codable>(
        _ url: String,
        parameters: Parameters? = nil
    ) async throws -> T {
        
        let result = try await session
            .request(
                url,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default
            )
            .serializingDecodable(T.self)
            .value
        
        return result
    }
}

extension NetworkManager {
    
    func post<T: Codable>(
        _ url: String,
        parameters: Parameters
    ) async throws -> T {
        
        return try await session
            .request(
                url,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default
            )
            .serializingDecodable(T.self)
            .value
    }
}

extension NetworkManager {
    
    func postMultipart<T: Codable>(
        _ url: String,
        parameters: [String: String]
    ) async throws -> T {
        
        return try await session
            .upload(
                multipartFormData: { formData in
                    
                    parameters.forEach { key, value in
                        formData.append(
                            Data(value.utf8),
                            withName: key
                        )
                    }
                },
                to: url,
                method: .post
            )
            .serializingDecodable(T.self)
            .value
    }
}

extension NetworkManager {
    
    func uploadImage<T: Codable>(
        _ url: String,
        imageData: Data,
        name: String = "donsocialot",
        fileName: String = "donsocialot.jpg",
        parameters: [String: String]? = nil
    ) async throws -> T {
        
        return try await session
            .upload(
                multipartFormData: { formData in
                    
                    formData.append(
                        imageData,
                        withName: name,
                        fileName: fileName,
                        mimeType: "image/jpeg"
                    )
                    
                    parameters?.forEach { key, value in
                        formData.append(Data(value.utf8), withName: key)
                    }
                },
                to: url
            )
            .serializingDecodable(T.self)
            .value
    }
}

