//
//  ImagePickerViewModel.swift
//  DeepLook-SwiftUI-Demo
//
//  Created by Amir Lahav on 10/07/2021.
//

import Foundation

#if os(iOS)
import PhotosUI
public final class ImagePickerViewModel: ObservableObject {
    
    public init() {  }
    
    @Published public var selectedImages: [String] = []
    @Published public var isPresentingImagePicker = false
            
    public func choosePhoto() {
        isPresentingImagePicker = true
    }
    
    public func didSelectImages(_ image: [String]) {
        selectedImages = image
        isPresentingImagePicker = false
    }
}

extension PHPickerResult: Identifiable {
    public var id: String {
        UUID().uuidString
    }
    
    
}
#elseif os(macOS)
public final class ImagePickerViewModel: ObservableObject {
    
    public init() {
        
    }
     @Published public var selectedImages: [URL] = []
     @Published public var isPresentingImagePicker = false
            
    public func choosePhoto() {
        isPresentingImagePicker = true
    }
    
    public func didSelectImages(_ image: [URL]) {
        selectedImages = image
        isPresentingImagePicker = false
    }

}
#endif
