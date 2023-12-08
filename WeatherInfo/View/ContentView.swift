//
//  ContentView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 07.12.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            WeatherView(viewModel: WeatherViewModel())
        }
        .preferredColorScheme(.light)
    }
}

#Preview {

    ContentView()
}
