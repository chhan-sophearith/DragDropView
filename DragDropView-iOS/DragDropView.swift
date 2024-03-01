//
//  DragDropView.swift
//  DragDropView-iOS
//
//  Created by Chhan Sophearith on 1/3/24.
//

import SwiftUI

struct DragDropView: View {
    @State private var draggedColor: Color?
    @State private var colors: [Color] = [.purple, .blue, .gray, .green, .yellow, .orange, .red]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Spacer()
                    .frame(height: 40)
                
                ForEach(colors, id: \.self) { color in
                    ColorItemView(backgroundColor: color)
                        .onDrag {
                            self.draggedColor = color
                            return NSItemProvider()
                        }
                        .onDrop(of: [.text],
                                delegate: DropViewDelegate(destinationItem: color, colors: $colors, draggedItem: $draggedColor)
                        )
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
        .background(Color.pink)
    }
    

}

struct ColorItemView: View {
    
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            Spacer()
            Text(backgroundColor.description.capitalized)
            Spacer()
        }
        .padding(.vertical, 40)
        .background(backgroundColor)
        .cornerRadius(20)
    }
}

struct DropViewDelegate: DropDelegate {
    
    let destinationItem: Color
    @Binding var colors: [Color]
    @Binding var draggedItem: Color?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        // Swap Items
        if let draggedItem {
            let fromIndex = colors.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = colors.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.colors.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
