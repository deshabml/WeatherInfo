//
//  WeatherSelectCityView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

struct WeatherSelectCityView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: WeatherSelectCityViewModel

    var body: some View {
        VStack {
            CityView(viewModel: viewModel.cityVM)
            temperaturePerDay
            Spacer()
        }
        .modifier(BackgroundElement(completion: {
            coordinator.goBack()
        }))
        .onAppear {
            viewModel.getWeather(city: coordinator.selectedCity)
        }
    }
}

#Preview {

    WeatherSelectCityView(viewModel: WeatherSelectCityViewModel())
        .environmentObject(Coordinator())
}

extension WeatherSelectCityView {

    private var temperaturePerDay: some View {
        VStack(spacing: 6) {
            Text(coordinator.tempDescription(viewModel.weatherData.mainTemp))
                .font(.custom("AvenirNext-Bold",
                              size: 48))
            Divider()
                .background(.white)
            if viewModel.weatherData.weatherIcon.isEmpty {
                Text(viewModel.weatherData.weatherDescription)
                    .font(.custom("AvenirNext-Bold",
                                  size: 20))
            } else {
                Image(viewModel.weatherData.weatherIcon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,
                           height: 100)
            }

            Text(coordinator.temperatureRange(weatherData: viewModel.weatherData))
                .font(.custom("AvenirNext-Bold",
                              size: 20))
        }
        .padding()
        .background(Color("BackgroundElement"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}
