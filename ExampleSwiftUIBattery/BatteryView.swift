//
//  BatteryView.swift
//  ExampleSwiftUIBattery
//
//  Created by Samuel Rodriguez-Lozano on 17/11/2022.
//

import SwiftUI

struct BatteryView: View {
    @Binding var level: Double
    @Binding var fill : Color
    @State private var opacity = 0.0
    @State private var scale = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "battery.0")
                .resizable()
                .scaledToFit()
                .font(.headline.weight(.ultraLight))
                .foregroundColor(.white)
                .background(
                    Rectangle()
                        .fill(fill)
                        .scaleEffect(x: level, y: 1, anchor: .leading)
                )
                .mask(
                    Image(systemName: "battery.100")
                        .resizable()
                        .scaledToFit()
                        .font(.headline.weight(.ultraLight))
                )
                .frame(width: 300)
                .padding()
            
            Text("\(Int(self.level * 100))%")
                .animation(nil)
                .opacity(self.opacity)
                .scaleEffect(self.scale)
            
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    self.opacity = 1.0
                    self.scale = 2.0
                }
            }
        }
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(level: .constant(0.2), fill: .constant(.green))
    }
}
