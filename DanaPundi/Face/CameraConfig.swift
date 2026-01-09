//
//  CameraConfig.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/6.
//


import UIKit
import AVFoundation

typealias CameraCompletion = (UIImage?) -> Void

struct CameraConfig {
    var cameraDevice: UIImagePickerController.CameraDevice = .rear
    var allowsEditing: Bool = false
    var maxFileSizeKB: Int = 800
    
    static let `default` = CameraConfig()
    
    init(
        cameraDevice: UIImagePickerController.CameraDevice = .rear,
        allowsEditing: Bool = false,
        maxFileSizeKB: Int = 800
    ) {
        self.cameraDevice = cameraDevice
        self.allowsEditing = allowsEditing
        self.maxFileSizeKB = maxFileSizeKB
    }
}

class CameraManager: NSObject {
    
    static let shared = CameraManager()
    
    private var completion: CameraCompletion?
    private var currentConfig: CameraConfig = .default
    
    func takePhoto(from viewController: UIViewController, completion: @escaping CameraCompletion) {
        takePhoto(from: viewController, config: .default, completion: completion)
    }
    
    func takePhoto(from viewController: UIViewController, config: CameraConfig, completion: @escaping CameraCompletion) {
        self.completion = completion
        self.currentConfig = config
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            presentCamera(from: viewController, config: config)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.presentCamera(from: viewController, config: config)
                    } else {
                        self?.showPermissionAlert(in: viewController)
                        completion(nil)
                    }
                }
            }
            
        case .denied, .restricted:
            showPermissionAlert(in: viewController)
            completion(nil)
            
        @unknown default:
            completion(nil)
        }
    }
    
    func takePhotoWithFrontCamera(from viewController: UIViewController, completion: @escaping CameraCompletion) {
        let config = CameraConfig(cameraDevice: .front)
        takePhoto(from: viewController, config: config, completion: completion)
    }
    
    func takePhotoWithRearCamera(from viewController: UIViewController, completion: @escaping CameraCompletion) {
        let config = CameraConfig(cameraDevice: .rear)
        takePhoto(from: viewController, config: config, completion: completion)
    }
    
    func takePhotoWithEditing(from viewController: UIViewController, cameraDevice: UIImagePickerController.CameraDevice = .rear, completion: @escaping CameraCompletion) {
        let config = CameraConfig(cameraDevice: cameraDevice, allowsEditing: true)
        takePhoto(from: viewController, config: config, completion: completion)
    }
    
    private func presentCamera(from viewController: UIViewController, config: CameraConfig) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion?(nil)
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = config.cameraDevice
        imagePicker.cameraCaptureMode = .photo
        imagePicker.allowsEditing = config.allowsEditing
        
        
        viewController.present(imagePicker, animated: true) {
            if config.cameraDevice == .front {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                    self?.hidePickerView(pickerView: imagePicker.view)
                }
            }
        }
    }
    
    private func showPermissionAlert(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "需要相机权限",
            message: "请在设置中开启相机权限以使用拍照功能",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func compressImage(_ image: UIImage, maxFileSizeKB: Int) -> UIImage? {
        var compression: CGFloat = 1.0
        let maxFileSize = maxFileSizeKB * 1024
        
        guard var imageData = image.jpegData(compressionQuality: compression) else {
            return image
        }
        
        if imageData.count <= maxFileSize {
            return image
        }
        
        while imageData.count > maxFileSize && compression > 0 {
            compression -= 0.1
            if let newData = image.jpegData(compressionQuality: compression) {
                imageData = newData
            } else {
                break
            }
        }
        
        return UIImage(data: imageData)
    }
}

extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var image: UIImage?
        
        if currentConfig.allowsEditing, let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            image = originalImage
        }
        
        if let originalImage = image {
            let compressedImage = compressImage(originalImage, maxFileSizeKB: currentConfig.maxFileSizeKB)
            completion?(compressedImage)
        } else {
            completion?(nil)
        }
        
        completion = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        completion?(nil)
        completion = nil
    }
}

extension CameraManager {
    
    private func hidePickerView(pickerView: UIView) {
        if #available(iOS 26, *) {
            let name = "SwiftUI._UIGraphicsView"
            if let cls = NSClassFromString(name) {
                for view in pickerView.subviews {
                    if view.isKind(of: cls) {
                        if view.bounds.width == 48 && view.bounds.height == 48 {
                            if view.frame.minX > UIScreen.main.bounds.width / 2.0 {
                                view.isHidden = true
                                return
                            }
                        }
                    }
                    hidePickerView(pickerView: view)
                }
            }
        }else {
            let name = "CAMFlipButton"
            for bbview in pickerView.subviews {
                if bbview.description.contains(name) {
                    bbview.isHidden = true
                    return
                }
                hidePickerView(pickerView: bbview)
            }
        }
    }
    
}
