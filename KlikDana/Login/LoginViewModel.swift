//
//  Untitled.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

class LoginViewModel {
    
    func codeApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/paginitor", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    func loginApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/vid", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
