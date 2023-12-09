//
//  cityView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

struct CityView: View {

    @StateObject var viewModel: CityViewModel

    var body: some View {
        Text(viewModel.text)
            .font(.custom("AvenirNext-Bold",
                          size: 24))
            .background(
                Color("DarkSea").blur(radius: 30))
            .frame(height: 50)
    }
}

#Preview {
    CityView(viewModel: CityViewModel())
}
