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
                    CityView(viewModel: viewModel.cityVM)
                    temperaturePerDay
                    weatherByHours
                    statisticByDay
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
            if NetworkMonitor.shared.isConnected {
                searchButton
                search
            } else {
                dataRelevanceInterval
            }
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

    private var temperaturePerDay: some View {
        VStack(spacing: 6) {
            Text(coordinator.tempDescription(viewModel.weatherData.mainTemp))
                .font(.custom("AvenirNext-Bold",
                              size: 60))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(viewModel.weatherData.weatherDescription)
                .font(.custom("AvenirNext-Bold",
                              size: 20))
                .background(
                    Color("DarkSea").blur(radius: 30))
            Text(coordinator.temperatureRange(weatherData: viewModel.weatherData))
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
                            Text(coordinator.tempDescription(viewModel.statisticsByHour[index].temp))
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
                                coordinator.goToWeatherSelectCity(city: viewModel.citys[index])
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

    private var statisticByDay: some View {
        VStack {
            ForEach(0 ..< viewModel.statisticsByDay.count, id: \.self) { index in
                    HStack {
                        Text("\(viewModel.weekDay(index: index))")
                            .font(.custom("AvenirNext-Bold",
                                          size: 16))
                            .frame(width: 30)
                        Image(viewModel.statisticsByDay[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        Text("\(viewModel.statisticsByDay[index].pop)%")
                            .font(.custom("AvenirNext-Bold",
                                          size: 16))
                            .frame(width: 45)
                        Text("\(coordinator.tempDescription(viewModel.statisticsByDay[index].min))")
                            .font(.custom("AvenirNext-Bold",
                                          size: 16))
                            .frame(width: 40)
                        temperatureGraph(index: index)
                        Text("\(coordinator.tempDescription(viewModel.statisticsByDay[index].max))")
                            .font(.custom("AvenirNext-Bold",
                                          size: 16))
                            .frame(width: 40)
                    }
                    .font(.custom("AvenirNext", size: 16))
            }
        }
        .padding()
        .background(Color("BackgroundElement"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }

    private var dataRelevanceInterval: some View {
        VStack {
            HStack {
                Spacer()
                Text(viewModel.dataRelevanceInterval())
                    .font(.custom("AvenirNext",
                                  size: 20))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color("DarkSea"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 40)
            }
            Spacer()
        }
    }

    private func temperatureGraph(index: Int) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 140, height: 25)
                .foregroundStyle(.gray)
                .padding(.leading, 0)
            RoundedRectangle(cornerRadius: 15)
                .frame(width: CGFloat(viewModel.widthDeyTemp(index: index)), height: 25)
                .foregroundStyle(.blue.opacity(0.6))
                .padding(.leading, CGFloat(viewModel.paddingTemp(index: index)))
        }
    }
}
