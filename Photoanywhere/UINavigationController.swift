//
//  UINavigationController.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/14.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI
import UIKit

extension UINavigationController: UINavigationControllerDelegate {
    
    convenience init(rootView: AnyView) {
        
        let hostingView = UIHostingController(rootView: rootView)
        self.init(rootViewController: hostingView)
        
        self.delegate = self
    }
    
    public func pushView(view: AnyView) {
        let hostingView = UIHostingController(rootView: view)
        
        self.pushViewController(hostingView, animated: true)
    }
    
    public func popView() {
        self.popViewController(animated: true)
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.isHidden = false
    }
    
}
