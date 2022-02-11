//
//  ImagePicker.swift
//  DeepLook-SwiftUI-Demo
//
//  Created by Amir Lahav on 10/07/2021.
//

import SwiftUI

#if os(iOS)
import PhotosUI
public struct ImagePicker: UIViewControllerRepresentable {
    
    public static var defaultConfiguration: PHPickerConfiguration {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.filter = .any(of: [.images,.livePhotos,.videos])
        configuration.selectionLimit = 200
        return configuration
    }
    
    public static var defaultSingleConfiguration: PHPickerConfiguration {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.filter = .any(of: [.images,.livePhotos,.videos])
        configuration.selectionLimit = 1
        return configuration
    }
    
    public typealias UIViewControllerType = PHPickerViewController
    
    public let completionHandler: ([String]) -> Void
    public let config: PHPickerConfiguration
    
    public init(completionHandler: @escaping ([String]) -> Void,
                config: PHPickerConfiguration) {
        self.completionHandler = completionHandler
        self.config = config
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController,
                                context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
         Coordinator(completionHandler: completionHandler)
    }
    
    public final class Coordinator: NSObject, PHPickerViewControllerDelegate {
       
        public let completionHandler: ([String]) -> Void
        public init(completionHandler: @escaping ([String]) -> Void) {
            self.completionHandler = completionHandler
        }
        
        public func picker(_ picker: PHPickerViewController,
                           didFinishPicking results: [PHPickerResult]) {
            let identifiers = results.compactMap(\.assetIdentifier)
            completionHandler(identifiers)
        }
    }
}
#elseif os(macOS)

public struct ImagePicker {
    
    public static func makePickerPanel(didSelectImages: @escaping ([URL]) -> Void, allowsMultipleSelection: Bool = true){
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select Photos"
        openPanel.allowsMultipleSelection = allowsMultipleSelection
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["png","jpg","jpeg","HEIC"]
        openPanel.begin { result in
            if result == .OK {
                didSelectImages(openPanel.urls)
            }
        }
    }
}
#endif
