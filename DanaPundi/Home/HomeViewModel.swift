//
//  HomeViewModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

class HomeViewModel {
    
    /// home_data_api
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
    
    /// click_product_api
    func clickProductApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/sollion", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// detail_api
    func detailApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/western", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
