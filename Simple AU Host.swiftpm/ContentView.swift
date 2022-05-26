import SwiftUI

struct ContentView: View {
    @State var audioUnitList: [AudioUnitListNode] = []
    
    var body: some View {
        VStack {
            if let audioUnitList = audioUnitList {
                List(audioUnitList, children: \.children) { au in
                    Text(au.description)
                }
            }
        }
        .task {
            audioUnitList = try! await buildAudioUnitListNodeTree()
        }
    }
}
