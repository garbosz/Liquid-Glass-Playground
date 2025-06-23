//
//  ContentView.swift
//  Liquid Glass Playground
//
//  Created by Zac Garbos on 2025-06-21.
//

import SwiftUI
import SwiftData

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct VerticallyScrollingSwiftIconsBackground: View {
    let iconCount = 10
    let iconSize: CGFloat = 50
    let scrollSpeed: CGFloat = 70 // points per second
    let colors: [Color] = [.orange, .cyan, .green, .yellow, .pink, .purple, .mint, .blue, .red, .teal]
    let symbols: [String] = ["swift", "bolt.fill", "star.fill", "flame.fill", "cloud.fill", "moon.fill", "sun.max.fill", "leaf.fill", "heart.fill", "globe"]

    var body: some View {
        GeometryReader { geometry in
            TimelineView(.periodic(from: .now, by: 1/60)) { context in
                let time = context.date.timeIntervalSinceReferenceDate
                let colHeight = CGFloat(iconCount) * iconSize
                let offset = CGFloat(time * Double(scrollSpeed)).truncatingRemainder(dividingBy: colHeight)
                
                let makeColumn: (CGFloat) -> some View = { yBase in
                    VStack(spacing: 0) {
                        ForEach(0..<iconCount, id: \.self) { i in
                            Image(systemName: symbols[i % symbols.count])
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(colors[i % colors.count].opacity(0.7))
                        }
                    }
                    .offset(y: yBase)
                }
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        makeColumn(offset)
                        makeColumn(-colHeight + offset)
                    }
                    .frame(width: iconSize, height: geometry.size.height, alignment: .center)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var buttonTintColor: Color = .clear
    let colorOptions: [Color] = [.clear, .red, .orange, .yellow, .green, .blue, .indigo, .purple]
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VerticallyScrollingSwiftIconsBackground()
                VStack {
                    Button("Im a Button"){}
                        .padding(30)
                        .glassEffect(in: .rect(cornerRadius:16))
                    Text("Liquid Glass")
                        .font(.title)
                        .padding()
                        .glassEffect()
                    Menu {
                        ForEach(colorOptions, id: \.self) { color in
                            Button {
                                self.buttonTintColor = color
                            } label: {
                                Label(color.description.capitalized, systemImage: "circle.fill")
                                    .tint(color) // Make the circle the correct color
                            }
                        }
                    } label: {
                        Text("Choose Tint")
                            .font(.title)
                            .padding()
                            
                    }
                    .glassEffect(.regular.tint(buttonTintColor.opacity(1)).interactive())
                    .accessibilityLabel("Activate Liquid Glass effect")
                    Menu{
                        
                    } label: {
                        Text("Menu")
                            .font(.title)
                            .padding()
                            .glassEffect()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)        }
        }
    }
}
#Preview {
    ContentView()
}
