import SwiftUI

struct ContentView: View {
    @State var audioUnitList: [AudioUnitListNode] = []
    
    var body: some View {
        NavigationView {
            if let audioUnitList = audioUnitList {
                List(audioUnitList, children: \.children) { au in
                    if let component = au.audioComponent {
                        NavigationLink {
                            AudioUnitView(audioUnit: component)
                        } label: {
                            AudioUnitRow(audioUnit: component)
                        }
                    } else {
                        Text(au.name)
                    }
                }
                .navigationTitle("AudioUnit List")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationViewStyle(.stack)
        .task {
            audioUnitList = try! await buildAudioUnitListNodeTree()
        }
    }
}
