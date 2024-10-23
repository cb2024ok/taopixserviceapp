//
//  ProgressView.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/08/31.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    @Binding var value: Double

    var body: some View { 
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.blue)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}
