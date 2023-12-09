//
//  MainView.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(MyPage.weatherView)
                .navigationDestination(for: MyPage.self) { page in
                    coordinator.getPage(page)
                }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {

    MainView()
        .environmentObject(Coordinator())
}
