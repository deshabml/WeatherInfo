//
//  WeatherView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import SwiftUI

struct WeatherView: View {

    @StateObject var viewModel: WeatherViewModel
    @State var isShowSearch = false

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                ZStack {
                    cityView
                    SearchButton
                }
                temperaturePerDay
                weatherByHours
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
        Text(viewModel.weatherData?.name ?? "-")
            .font(.custom("AvenirNext-Bold", size: 24))
            .background(
                Color("DarkSea").blur(radius: 30))
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
                    Color("DarkSea").blur(radius: 20))
        }
    }

    private var weatherByHours: some View {
        VStack {
            HStack {
                Text("Прогноз на следующие 6 часов:")
                    .font(.custom("AvenirNext-Bold", size: 16))
                Spacer()
            }
            Divider()
                .background(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach( 0 ..< viewModel.statisticsByHour.count, id: \.self) { index in
                        VStack(spacing: 0) {
                            Text((index == 0) ? "Сейчас" : viewModel.statisticsByHour[index].hour)
                                .font(.custom("AvenirNext-Bold", size: 16))
                            Image(viewModel.statisticsByHour[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            Text(viewModel.tempDescription(viewModel.statisticsByHour[index].temp))
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color("BackgroundElement"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }

    private var SearchButton: some View {
        HStack {
            Spacer()
            Button {
                isShowSearch.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal)
        }
    }
}
