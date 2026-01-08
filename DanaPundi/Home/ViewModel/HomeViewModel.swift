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
    
    /// city_list_info
    func cityListApi() async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.get("/sistatory/strigos")
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
        
        var apiUrl = "cornature"
        
        if LanguageManager.currentLanguage == .id {
            apiUrl = "/sistatory/claimacity"
        }else {
            apiUrl = "/sistatory/cornature"
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart(apiUrl, parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// get_work_info
    func workApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/mustship", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// save_work_info
    func saveWorkApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/difficultaire", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// get_contact_info
    func contactApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/val", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// save_contact_info
    func saveContactApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/discuss", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// upload_all_contact_info
    func uploadAllContactApi(parameters: [String: String]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/tornation", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// get_wallet_info
    func walletApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/ruspay", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// save_wallet_info
    func saveWalletApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/stenics", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// to_apply_order_info
    func toOrderApplyApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/appear", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
    /// to_order_list_info
    func orderListApi(parameters: [String: String]) async throws -> BaseModel {
        
        LoadingIndicator.shared.show()
        
        defer {
            LoadingIndicator.shared.hide()
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.postMultipart("/sistatory/semaair", parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}
