//
//  ContactManager.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/7.
//

import UIKit
import Contacts
import ContactsUI

class ContactManager: NSObject {
    
    typealias ContactCompletionHandler = ([[String: String]]?, Error?) -> Void
    
    private var completionHandler: ContactCompletionHandler?
    private weak var presentingViewController: UIViewController?
    
    func pickSingleContact(from viewController: UIViewController, completion: @escaping ContactCompletionHandler) {
        self.presentingViewController = viewController
        self.completionHandler = completion
        
        checkAuthorizationStatus { [weak self] authorized in
            guard let self = self else { return }
            
            if authorized {
                self.presentContactPicker()
            } else {
                self.showPermissionDeniedAlert()
                completion(nil, NSError(domain: "ContactManager", code: 403, userInfo: [NSLocalizedDescriptionKey: "ContactManager"]))
            }
        }
    }
    
    // MARK: - 获取所有联系人
    func fetchAllContacts(completion: @escaping ContactCompletionHandler) {
        checkAuthorizationStatus { authorized in
            if authorized {
                self.fetchContactsFromStore(completion: completion)
            } else {
                completion(nil, NSError(domain: "ContactManager", code: 403, userInfo: [NSLocalizedDescriptionKey: "ContactManager"]))
            }
        }
    }
    
    private func checkAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized, .limited:
            completion(true)
            
        case .notDetermined:
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
            
        case .denied, .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    private func presentContactPicker() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        contactPicker.predicateForSelectionOfContact = NSPredicate(value: true)
        
        presentingViewController?.present(contactPicker, animated: true, completion: nil)
    }
    
    private func fetchContactsFromStore(completion: @escaping ContactCompletionHandler) {
        DispatchQueue.global(qos: .userInitiated).async {
            let store = CNContactStore()
            let keysToFetch = [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            request.sortOrder = .givenName
            
            var contactsArray = [[String: String]]()
            
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    if !contact.phoneNumbers.isEmpty {
                        var contactDict = [String: String]()
                        
                        let fullName = "\(contact.familyName)\(contact.givenName)"
                        contactDict["catchtic"] = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        let phoneNumbers = contact.phoneNumbers.map { phoneNumber in
                            let cleanNumber = phoneNumber.value.stringValue
                                .replacingOccurrences(of: " ", with: "")
                                .replacingOccurrences(of: "-", with: "")
                                .replacingOccurrences(of: "(", with: "")
                                .replacingOccurrences(of: ")", with: "")
                            return cleanNumber
                        }
                        
                        contactDict["paginitor"] = phoneNumbers.joined(separator: ",")
                        
                        if !phoneNumbers.isEmpty {
                            contactsArray.append(contactDict)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    completion(contactsArray, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(
            title: "需要通讯录权限",
            message: "请前往设置允许访问通讯录以选择联系人",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "前往设置", style: .default) { _ in
            self.openAppSettings()
        })
        
        presentingViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
    
    private func handleSelectedContact(_ contact: CNContact) {
        var contactDict = [String: String]()
        
        let fullName = "\(contact.familyName) \(contact.givenName)"
        contactDict["catchtic"] = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let phoneNumbers = contact.phoneNumbers.map { phoneNumber in
            let cleanNumber = phoneNumber.value.stringValue
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
            return cleanNumber
        }
        
        contactDict["paginitor"] = phoneNumbers.joined(separator: ",")
        
        completionHandler?([contactDict], nil)
        completionHandler = nil
    }
}

// MARK: - CNContactPickerDelegate
extension ContactManager: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        handleSelectedContact(contact)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        completionHandler?(nil, NSError(domain: "ContactManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "ContactManager"]))
        completionHandler = nil
    }
}
