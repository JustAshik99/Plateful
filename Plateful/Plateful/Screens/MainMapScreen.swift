//
//  MainMapScreen.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 18/03/2022.
//

import SwiftUI

struct MainMapScreen: View {
    @ObservedObject var locationManager = Location.shared
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MainMapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainMapScreen()
    }
}
