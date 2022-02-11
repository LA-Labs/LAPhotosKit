//
//  AsyncImageViewModel.swift
//  DeepLook-SwiftUI-Demo (iOS)
//
//  Created by Amir Lahav on 11/07/2021.
//

import Foundation
import Combine
#if os(iOS)
import PhotosUI

public class AsyncImageViewModel: ObservableObject {
    
    public static var defaultOptions: PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .opportunistic
        requestOptions.isSynchronous = false
        return requestOptions
    }
    
    let identifier: String
    let requestedSize: CGSize
    let requestOptions: PHImageRequestOptions
    
    @Published var image: UIImage? = nil
    
    public init(identifier: String,
         requestedSize: CGSize,
         requestOptions: PHImageRequestOptions = AsyncImageViewModel.defaultOptions)
    {
        self.identifier = identifier
        self.requestedSize = requestedSize
        self.requestOptions = requestOptions
    }
    
    public func loadImage() {
        guard  let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [identifier],
                                                 options: nil).firstObject else { return }

        PHCachingImageManager.default().requestImage(for: phAsset,
                                                     targetSize: requestedSize,
                                                     contentMode: .aspectFit,
                                                     options: requestOptions) { image, _ in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
#endif
