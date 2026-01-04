//
//  NetworkManager.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import Alamofire
import Toast_Swift

let base_url = "http://149.129.255.14:11003/honorain"

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
        let apiUrl = APIRequestBuilder.buildURLString(api: base_url + url) ?? ""
        let result = try await session
            .request(
                apiUrl,
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
    
    func postMultipart<T: Codable>(
        _ url: String,
        parameters: [String: String]
    ) async throws -> T {
        let apiUrl = APIRequestBuilder.buildURLString(api: base_url + url) ?? ""
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
                to: apiUrl,
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
        let apiUrl = APIRequestBuilder.buildURLString(api: base_url + url) ?? ""
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
                to: apiUrl
            )
            .serializingDecodable(T.self)
            .value
    }
}

class ToastManager {
    static func showMessage(_ message: String) {
        guard let window = UIApplication.shared.windows.first else { return }
        window.makeToast(message, duration: 3.0, position: .center)
    }
}
