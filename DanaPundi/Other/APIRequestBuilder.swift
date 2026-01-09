//
//  APIRequestBuilder.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import Foundation

final class APIRequestBuilder {
    
    static func buildURLString(api: String) -> String? {
        let params = RequestParamBuilder.build()
        return api.appendingCommonParams(params)
    }
}

extension String {
    
    func appendingCommonParams(_ params: [String: Any]) -> String? {
        
        guard let url = URL(string: self),
              let newURL = url.appendingQueryParams(params) else {
            return nil
        }
        
        return newURL.absoluteString
    }
}

extension URL {
    
    func appendingQueryParams(_ params: [String: Any]) -> URL? {
        
        guard var components = URLComponents(
            url: self,
            resolvingAgainstBaseURL: false
        ) else {
            return nil
        }
        
        var queryItems = components.queryItems ?? []
        
        params.forEach { key, value in
            queryItems.append(
                URLQueryItem(name: key, value: "\(value)")
            )
        }
        
        components.queryItems = queryItems
        return components.url
    }
}
