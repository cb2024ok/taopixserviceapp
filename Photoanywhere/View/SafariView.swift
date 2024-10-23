//
//  SafariView.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/20.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI
import WebKit
import SafariServices

// MARK: -- SafariView --
struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    //@Binding var showSheetView: Bool
    
    var url: URL?
    let onFinished: () -> Void
    
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        //return SFSafariViewController(url: (url)!)
        let controller = SFSafariViewController(url: url!)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView
        
        init(_ parent: SafariView) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onFinished()
        }
    
        /*
         func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
            print("Reditrect URL:\(URL)")
        }
         */
    }
}
