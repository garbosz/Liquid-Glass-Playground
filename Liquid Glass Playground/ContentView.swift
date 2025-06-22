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
    @State private var buttonTintColor: Color = .blue
    let colorOptions: [Color] = [.blue, .green, .orange, .red, .purple, .clear]
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VerticallyScrollingSwiftIconsBackground()
                VStack {
                    // 2. MENU: We wrap your button in a Menu.
                    // The 'label' is what the user taps on. The content inside
                    // the curly braces is the list of options that will appear.
                    Menu {
                        // We loop over our colorOptions array to create a button for each one.
                        ForEach(colorOptions, id: \.self) { color in
                            Button {
                                // This is the action: when a color is tapped,
                                // we update our state variable.
                                self.buttonTintColor = color
                            } label: {
                                // This makes the menu option look nice, with a colored
                                // circle next to the color's name.
                                Label(color.description.capitalized, systemImage: "circle.fill")
                                    .tint(color) // Make the circle the correct color
                            }
                        }
                    } label: {
                        // This is your original button. It now acts as the trigger for the menu.
                        Text("Liquid Glass")
                            .padding()
                            .foregroundStyle(.black)
                    }
                    .buttonStyle(.glass)
                    .glassEffect(.regular.tint(buttonTintColor).interactive())
                    .accessibilityLabel("Activate Liquid Glass effect")
                    // 3. TINT: We apply the selected color to the whole Menu view.
                    // Because our @State variable is used here, SwiftUI knows to
                    // update the color whenever 'buttonTintColor' changes.
                    .tint(buttonTintColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)        }
        }
    }
}
#Preview {
    ContentView()
}
