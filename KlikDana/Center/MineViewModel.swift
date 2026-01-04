//
//  MineViewModel.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

class MineViewModel {
    
    func centerApi() async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/radiwise")
            return model
        } catch {
            throw error
        }
    }
    
}
