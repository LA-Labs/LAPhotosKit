//
//  Image Extension.swift
//  
//
//  Created by Amir Lahav on 16/07/2021.
//

import SwiftUI

public struct RatioModifier: ViewModifier {
    
    let ratio: CGFloat
   
    public init(ratio: CGFloat) {
        self.ratio = ratio
    }
    
    public func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .aspectRatio(contentMode: .fill)
        }
        .aspectRatio(ratio, contentMode: .fit)
    }
}

public extension Image {
    
    func ratioImage(ratio: CGFloat) -> some View {
        self.modifier(RatioModifier(ratio: ratio))
    }
    
    func squareImage() -> some View {
        ratioImage(ratio: 1.0)
    }
}

public extension AsyncImage {
    
    func ratioImage(ratio: CGFloat) -> some View {
        self.modifier(RatioModifier(ratio: ratio))
    }
    
    func squareImage() -> some View {
        ratioImage(ratio: 1.0)
    }
}
extension Image {
    @inlinable init(platformImage: PlatformImage) {
        #if os(macOS)
        self.init(nsImage: platformImage)
        #else
        self.init(uiImage: platformImage)
        #endif
    }
}
