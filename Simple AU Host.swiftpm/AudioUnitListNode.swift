import SwiftUI
import AVFoundation

struct AudioUnitListNode: Identifiable, CustomStringConvertible {
    let id = UUID()
    let name: String
    var audioComponent: AVAudioUnitComponent? = nil
    var children: [AudioUnitListNode]? = nil
    var description: String {
        get {
            return "\(name)"
        }
    }
    
    init(name: String, component: AVAudioUnitComponent) {
        self.name = name
        self.audioComponent = component
    }
    
    init(name: String, children: [AudioUnitListNode]) {
        self.name = name
        self.children = children
    }
}

func buildAudioUnitListNodeTree(audioUnits: [AVAudioUnitComponent]) -> AudioUnitListNode {
    var typeNodes: [AudioUnitListNode] = []

    for (type, typeName) in AudioUnitRepository.availableTypes {
        var subTypeNodes: [AudioUnitListNode] = []
        for (subType, subTypeName) in AudioUnitRepository.availableSubTypes {
            let components = AudioUnitRepository.findAudioUnits(byType: type, bySubType: subType)
            if components.count > 0 {
                let componentNodes = components.map { comp in
                    AudioUnitListNode(name: comp.name, component: comp)
                }
                let subTypeNode = AudioUnitListNode(name: subTypeName, children: componentNodes)
                subTypeNodes.append(subTypeNode)
            }
        }
        
        if subTypeNodes.count > 0 {
            let typeNode = AudioUnitListNode(name: typeName, children: subTypeNodes)
            typeNodes.append(typeNode)
        }
    }
    
    let root = AudioUnitListNode(name: "AudioUnits", children: typeNodes)
    return root
}
