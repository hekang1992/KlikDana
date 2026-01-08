//
//  MineViewModel.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
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
    
    func logoutApi() async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/peaceent")
            return model
        } catch {
            throw error
        }
    }
    
    func deleteAccountApi() async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/federalesque")
            return model
        } catch {
            throw error
        }
    }
    
}
