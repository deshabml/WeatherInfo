//
//  WeatherView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 08.12.2023.
//

import SwiftUI

struct WeatherView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: WeatherViewModel
    @State var isShowSearch = false

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 10) {
                    cityView
                    temperaturePerDay
                    weatherByHours
                }
                Spacer()
            }
            .onTapGesture {
                isShowSearch = false
            }
            .modifier(BackgroundElement(isFirstSreen: true,
                                        completionFirst: {
                isShowSearch = false
            }))
            searchButton
            search
        }
        .animation(.easeInOut(duration: 0.3),
                   value: viewModel.citys)
        .animation(.easeInOut(duration: 0.3),
                   value: isShowSearch)
    }
    
}

#Preview {
    
    WeatherView(viewModel: WeatherViewModel())
        .environmentObject(Coordinator())
}

extension WeatherView {

    private var cityView: some View {
        Text(viewModel.weatherData?.name ?? "-")
            .font(.custom("AvenirNext-Bold",
                          size: 24))
            .background(
                Color("DarkSea").blur(radius: 30))
        .frame(height: 50)
    }

    private var temperaturePerDay: some View {
        VStack(spacing: 6) {
            Text(viewModel.tempDescription(viewModel.weatherData?.main.temp))
                .font(.custom("AvenirNext-Bold",
                              size: 60))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(viewModel.weatherDescriptionText())
                .font(.custom("AvenirNext-Bold",
                              size: 20))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(viewModel.temperatureRange())
                .font(.custom("AvenirNext-Bold",
                              size: 20))
                .background(
                    Color("DarkSea").blur(radius: 20))
        }
    }

    private var weatherByHours: some View {
        VStack {
            HStack {
                Text("Прогноз на следующие 6 часов:")
                    .font(.custom("AvenirNext-Bold",
                                  size: 16))
                Spacer()
            }
            Divider()
                .background(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0 ..< viewModel.statisticsByHour.count, id: \.self) { index in
                        VStack(spacing: 0) {
                            Text((index == 0) ? "Сейчас" : viewModel.statisticsByHour[index].hour)
                                .font(.custom("AvenirNext-Bold",
                                              size: 16))
                            Image(viewModel.statisticsByHour[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70,
                                       height: 70)
                            Text(viewModel.tempDescription(viewModel.statisticsByHour[index].temp))
                                .font(.custom("AvenirNext-Bold",
                                              size: 16))
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

    private var searchButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowSearch.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, 
                               height: 40)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }

    private var search: some View {
        VStack {
            if isShowSearch {
                VStack {
                    VStack {
                        TextField("Город", text: $viewModel.city)
                            .font(.custom("AvenirNext-Bold",
                                          size: 20))
                            .padding()
                            .foregroundColor(.black)
                        Divider()
                            .background(.black)
                        ForEach(0 ..< viewModel.citys.count, id: \.self) { index in
                            Button {
                                coordinator.goToWeatherSelectCity()
                            } label: {
                                HStack {
                                    Text(viewModel.citys[index])
                                        .font(.custom("AvenirNext", 
                                                      size: 18))
                                        .padding()
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                            Divider()
                                .background(.black)
                                .padding(.horizontal)
                        }
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}
