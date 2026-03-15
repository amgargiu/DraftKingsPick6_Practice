//
//  LogoImageView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import SwiftUI

struct LogoImageView: View {
    var body: some View {
        Image("basketball")
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
    }
}

#Preview {
    LogoImageView()
}
