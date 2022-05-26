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

func buildAudioUnitListNodeTree() async throws -> [AudioUnitListNode] {
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
        
        let allComponentsOfType = AudioUnitRepository.findAudioUnits(byType: type)
        for component in allComponentsOfType {
            let alreadyAdded = subTypeNodes.contains { node in 
                if let children = node.children {
                    return children.contains { $0.name == component.name }
                } else {
                    return false
                }
            }
            if !alreadyAdded {
                print("Adding an AU with no sub type: \(component.name)")
                subTypeNodes.append(AudioUnitListNode(name: component.name, component: component))
            }
        }
        
        if subTypeNodes.count > 0 {
            let typeNode = AudioUnitListNode(name: typeName, children: subTypeNodes)
            typeNodes.append(typeNode)
        }
    }
    
    return typeNodes
}
