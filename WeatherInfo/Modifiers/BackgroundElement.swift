//
//  BackgroundElement.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import SwiftUI

struct BackgroundElement: ViewModifier {

    var isFirstSreen = false
    var completionFirst: (()->())?
    var completion: (()->())?

    func body(content: Content) -> some View {
        if isFirstSreen {
            content
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                .onTapGesture {
                    completionFirst?()
                })
        } else {
            content
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: buttonBack(completion: {
                    completion?()
                }))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension BackgroundElement {

    @ViewBuilder
    func buttonBack(completion: @escaping ()->()) -> some View {
        Button {
            completion()
        } label: {
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFill()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
        }
    }
}
