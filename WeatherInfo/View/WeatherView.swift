//
//  WeatherView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import SwiftUI

struct WeatherView: View {

    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    
    WeatherView(viewModel: WeatherViewModel())
}
