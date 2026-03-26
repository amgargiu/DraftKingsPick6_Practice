struct DictionaryDebugView: View {
    // 1. Observe the service to see live updates
    @ObservedObject var service = PlayerTeamImagesDataService.shared

    var body: some View {
        List {
            // 2. Convert dictionary to a sorted array of elements
            let sortedKeys = service.teamdict.keys.sorted()

            ForEach(sortedKeys, id: \.self) { teamName in
                HStack {
                    Text(teamName)
                        .font(.headline)
                    
                    Spacer()
                    
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