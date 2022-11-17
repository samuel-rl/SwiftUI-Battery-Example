//
//  ContentView.swift
//  ExampleSwiftUIBattery
//
//  Created by Samuel Rodriguez-Lozano on 17/11/2022.
//

import SwiftUI

class BatteryModel: ObservableObject {
    @Published var batteryLevel: Double = 0.0
    @Published var batteryColor: Color = .gray
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.batteryLevel = Double(UIDevice.current.batteryLevel)
        self.batteryColor = getBatteryColor(for: UIDevice.current.batteryState)
    }
    
    private func getBatteryColor(for state: UIDevice.BatteryState) -> Color {
        switch state {
        case .unknown:
            return .gray
        case .unplugged:
            return .yellow
        case .charging:
            return .green
        case .full:
            return .green
        @unknown default:
            return .gray
        }
    }
}

struct ContentView: View {
    @ObservedObject private var batteryModel = BatteryModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                BatteryView(level: $batteryModel.batteryLevel, fill: $batteryModel.batteryColor)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
