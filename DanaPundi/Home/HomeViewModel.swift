//
//  HomeViewModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

class HomeViewModel {
    
    func homeApi() async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/cubage")
            return model
        } catch {
            throw error
        }
    }
    
}
