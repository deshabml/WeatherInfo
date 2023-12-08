//
//  WeatherSelectCityView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

struct WeatherSelectCityView: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        .modifier(BackgroundElement(completion: {
            coordinator.goBack()
        }))
    }

}

#Preview {
    WeatherSelectCityView()
        .environmentObject(Coordinator())
}
