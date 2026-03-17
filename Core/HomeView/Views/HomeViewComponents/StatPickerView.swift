//
//  StatPickerView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct StatPickerView: View {
    @Binding var selection: StatType
    @Namespace private var pickerTransition // 1. Add this namespace
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(StatType.allCases, id: \.self) { stat in
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { // 2. Use a spring for that "snappy" feel
                            selection = stat
                        }
                    } label: {
                        Text(stat.rawValue.capitalized)
                            .font(.system(size: 13, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selection == stat ? .white : .gray)
                            .padding(.bottom, 15)
                            .overlay(alignment: .bottom) {
                                // 3. The Logic:
                                if selection == stat {
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color(red: 0.95, green: 0.65, blue: 0.54), .orange],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(height: 4)
                                        // 4. This key line makes it slide:
                                        .matchedGeometryEffect(id: "activeTab", in: pickerTransition)
                                } else {
                                    // Empty transparent capsule keeps the layout consistent
                                    Capsule()
                                        .fill(.clear)
                                        .frame(height: 4)
                                }
                            }
                    }
                }
            }
            .padding(4)
            .padding(.horizontal)
            
            Divider()
        }
    }
}

#Preview {
    StatPickerView(selection: .constant(StatType.points))
        .background(Capsule()
            .fill(
                LinearGradient(colors: [Color(white: 0.15)], startPoint: .top, endPoint: .bottom))
        )
}
