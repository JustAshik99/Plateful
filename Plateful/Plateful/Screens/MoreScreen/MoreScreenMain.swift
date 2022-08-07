//
//  MoreScreenMain.swift
//  Plateful
//
//  Created by Ashik Ahnaf on 17/06/2022.
//

import SwiftUI

struct MoreScreenMain: View {
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    ZStack{
                        //Reference cell for each rectangle view, takes in parameter heading name, description and an image
                        MoreInformationCell(headingName: "Contact us", description: "Contact us regarding enquiries", systemImage: "phone.circle.fill")
                        }
                    .onTapGesture {
                        SendEmail(request: "enquiry")//open email application with pre filled data
                    }
                    ZStack{
                        MoreInformationCell(headingName: "Suggest feature", description: "Help us improve the app by suggesting new features", systemImage: "plus.circle.fill")
                            
                    }.onTapGesture {
                        SendEmail(request: "feature")
                    }
                    ZStack {
                        MoreInformationCell(headingName: "Share with friends", description: "Share the app with friends", systemImage: "square.and.arrow.up.circle.fill")
                    }.onTapGesture {
                        actionSheet() //opens action sheet with options to share via a medium
                    }
                    ZStack {
                        MoreInformationCell(headingName: "Report bug", description: "Help us improve your app experience", systemImage: "exclamationmark.bubble.circle.fill")
                    }.onTapGesture {
                        SendEmail(request: "bugreport")
                    }
                    Spacer()
                }.padding(3).navigationTitle("More Information") //title
                
            }
            
            
        }
        
    }
    func actionSheet() {
            guard let urlShare = URL(string: "https://testflight.apple.com/join/AZkzN1xh") else { return }
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    func SendEmail(request: String){
        let email = "info.plateful@gmail.com"
        switch request {
        case "enquiry":
            if let url = URL(string: "mailto:\(email)?subject=Enquiry&body=Enquiry:") {
                UIApplication.shared.openURL(url)
            }
            break
        case "feature":
            if let url = URL(string: "mailto:\(email)?subject=Feature%20Suggestion&body=Feature%20Suggestion:") {
                UIApplication.shared.openURL(url)
            }
            break
        case "bugreport":
            if let url = URL(string: "mailto:\(email)?subject=Bug%20Report&body=Let%20us%20know%20what%20happened:") {
                UIApplication.shared.openURL(url)
            }
            break
            
        default:
            break
            
        }
    }
}

