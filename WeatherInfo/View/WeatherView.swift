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
        VStack {
            VStack(spacing: 10) {
                cityView
                temperaturePerDay
            }
            Spacer()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea())
    }
    
}

#Preview {
    
    WeatherView(viewModel: WeatherViewModel())
}

extension WeatherView {

    private var cityView: some View {
        VStack {
            if viewModel.isChoosingCity {
                    TextField("Город", text: $viewModel.city)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(
                            Color("DarkSea").blur(radius: 30))
            } else {
                Text(viewModel.weatherData?.name ?? "-")
                    .font(.custom("AvenirNext-Bold", size: 24))
                    .onTapGesture {
                        viewModel.isChoosingCity.toggle()
                    }
            }
        }
        .frame(height: 50)
    }

    private var temperaturePerDay: some View {
        VStack(spacing: 6) {
            Text(viewModel.tempDescription(viewModel.weatherData?.main.temp))
                .font(.custom("AvenirNext-Bold", size: 60))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(viewModel.weatherDescriptionText())
                .font(.custom("AvenirNext-Bold", size: 20))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(viewModel.temperatureRange())
                .font(.custom("AvenirNext-Bold", size: 20))
                .background(
                    Color("DarkSea").blur(radius: 30))
        }
    }
}
