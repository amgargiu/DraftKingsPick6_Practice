//
//  PickPreviewShapeView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct PickPreviewShapeView: View {
    
    let player: PlayerModel
    
    var body: some View {
        ArrowRectangle()
            .frame(width: 200, height: 100)
            .foregroundStyle(Color.green)
        
        
    }
}

#Preview {
    PickPreviewShapeView(player: DevPreview.player)
}

extension PickPreviewShapeView {
    
    
    struct ArrowRectangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Start at the top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // Line to the top right (start of the arrow head)
            // We stop a bit early to leave room for the point
            path.addLine(to: CGPoint(x: rect.maxX * 0.8, y: rect.minY))
            
            // The Tip of the arrow (Center Right)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // Line back to the bottom right
            path.addLine(to: CGPoint(x: rect.maxX * 0.8, y: rect.maxY))
            
            // Line to the bottom left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            // Close the path back to the top left
            path.closeSubpath()
            
            return path
        }
    }
    
    
}
