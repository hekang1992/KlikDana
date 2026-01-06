//
//  HomeViewModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

import Foundation

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
    
    /// user_detail_info
    func userDetailApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/half", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// upload_image_info
    func uploadImageApi(parameters: [String: String], imageData: Data) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.uploadImage("/sistatory/problemling", imageData: imageData, parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// save_image_info
    func saveImageApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/claimacity", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
