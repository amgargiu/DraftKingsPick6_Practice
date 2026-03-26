//
//  DictionaryDebugView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/23/26.
//
import Foundation
import SwiftUI

struct DictionaryDebugView: View {
    // 1. Observe the service to see live updates
    @ObservedObject var service = PlayerTeamImagesDataService.shared

    var body: some View {
        List {
            // 2. Convert dictionary to a sorted array of elements
            let sortedKeys = service.teamdict.keys.sorted()
            let values = service.teamdict.values

            ForEach(sortedKeys, id: \.self) { teamName in
                HStack {
                    Text(teamName)
                        .font(.headline)
                    
                    Spacer()
                    Text("\(values.firstIndex(of: service.teamdict[teamName]!)!)")
                    // 3. Display the actual image from the dictionary
                    if let image = service.teamdict[teamName] {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .navigationTitle("Memory Debug")
    }
}

#Preview {
    DictionaryDebugView()
}
