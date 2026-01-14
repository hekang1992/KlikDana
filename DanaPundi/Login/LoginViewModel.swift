//
//  Untitled.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

class LoginViewModel {
    
    private func withLoading<T>(_ operation: () async throws -> T) async throws -> T {
        LoadingIndicator.shared.show()
        defer { LoadingIndicator.shared.hide() }
        return try await operation()
    }
    
    func codeApi(parameters: [String: String]) async throws -> BaseModel {
        try await withLoading {
            try await NetworkManager.shared.postMultipart("/sistatory/paginitor", parameters: parameters)
        }
    }
    
    func loginApi(parameters: [String: String]) async throws -> BaseModel {
        try await withLoading {
            try await NetworkManager.shared.postMultipart("/sistatory/vid", parameters: parameters)
        }
    }
}
