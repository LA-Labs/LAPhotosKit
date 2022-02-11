//
//  File.swift
//  
//
//  Created by Amir Lahav on 16/07/2021.
//

import Foundation
import SwiftUI

#if os(macOS)
public typealias PlatformImage = NSImage
#else
public typealias PlatformImage = UIImage
#endif

#if os(macOS)
public typealias PlatformView = NSView
#endif
#if os(iOS) || os(tvOS)
public typealias PlatformView = UIView
#endif
#if os(watchOS)
public typealias PlatformView = WKInterfaceObject
#endif

#if os(macOS)
public typealias PlatformViewRepresentable = NSViewRepresentable
#endif
#if os(iOS) || os(tvOS)
public typealias PlatformViewRepresentable = UIViewRepresentable
#endif
#if os(watchOS)
public typealias PlatformViewRepresentable = WKInterfaceObjectRepresentable
#endif

#if os(macOS)
extension NSViewRepresentable {
    typealias PlatformViewType = NSViewType
}
#endif
#if os(iOS) || os(tvOS)
extension UIViewRepresentable {
    typealias PlatformViewType = UIViewType
}
#endif
