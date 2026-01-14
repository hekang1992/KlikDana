//
//  MineViewModel.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

class MineViewModel {
    
    private func withLoading<T>(_ operation: () async throws -> T) async throws -> T {
        LoadingIndicator.shared.show()
        defer { LoadingIndicator.shared.hide() }
        return try await operation()
    }
    
    func centerApi() async throws -> BaseModel {
        try await withLoading {
            try await NetworkManager.shared.get("/sistatory/radiwise")
        }
    }
    
    func logoutApi() async throws -> BaseModel {
        try await withLoading {
            try await NetworkManager.shared.get("/sistatory/peaceent")
        }
    }
    
    func deleteAccountApi() async throws -> BaseModel {
        try await withLoading {
            try await NetworkManager.shared.get("/sistatory/federalesque")
        }
    }
}
