//
//  AsyncImage.swift
//  DeepLook-SwiftUI-Demo (iOS)
//
//  Created by Amir Lahav on 11/07/2021.
//

import SwiftUI
import PhotosUI
#if os(iOS)
public struct AsyncImage: View {
    
    @ObservedObject var viewModel: AsyncImageViewModel
    
    public init(identifier: String,
         requestedSize: CGSize) {
        self.viewModel = AsyncImageViewModel(identifier: identifier,
                                             requestedSize: requestedSize)
        if !identifier.isEmpty {
            self.viewModel.loadImage()
        }
    }
    
    public var body: some View {
        if let image = viewModel.image {
                Image(platformImage: image)
                    .resizable()
        }else {
            EmptyView()
        }

        
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(identifier: "", requestedSize: .zero)
    }
}
#elseif os(macOS)
public struct AsyncImage: View {
    let size: CGSize
    let identifier: URL
    
    public init(identifier: URL,
                requestedSize: CGSize) {
        self.identifier = identifier
        self.size = requestedSize
    }
    
    public var body: some View {
            let image = NSImage(byReferencing: identifier)
            Image(platformImage: image)
    }
    
}
#endif


