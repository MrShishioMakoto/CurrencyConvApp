//
//  CurrencyConvApp.swift
//  CurrencyConvApp
//
//  Created by GoncaloSAlmeida on 08/08/2024.
//

import SwiftUI

@main
struct CurrencyConvApp: App {
    @StateObject var viewModel = CurrencyConvViewModel(NetworkService(apiHost: "api.frankfurter.app"))
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    RatesView(viewModel: viewModel)
                }
                .tabItem {
                    Label(
                        title: { Text(LocalizableKeys.Tabs.rates) },
                        icon: { Image(systemName: Constants.SystemImage.rates) }
                    )
                    
                }
                NavigationView {
                    // TODO
                }
                .tabItem {
                    Label(
                        title: { Text(LocalizableKeys.Tabs.converter) },
                        icon: { Image(systemName: Constants.SystemImage.converter ) }
                    )
                }
            }
            .accentColor(.black)
        }
    }
}
