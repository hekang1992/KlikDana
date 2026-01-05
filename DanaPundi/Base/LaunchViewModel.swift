//
//  LaunchViewModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

class LaunchViewModel {
    
    func launchInfo(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/betweenot", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
