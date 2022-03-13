//
//  TitleRow.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import SwiftUI

//TO DO: HIDE BACK BUTTON

struct TitleRow: View {
    @EnvironmentObject private var text: TitleRowData
    @State private var isActive = false
    
    let rootViewController = UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive }
        .map {$0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter({ $0.isKeyWindow }).first?.rootViewController
    
    let buttonSize: CGFloat = 30
    
    //other user imageurl
    var imageUrl = URL(string: UserDefaults.standard.string(forKey: "otherUserImageUrl")!)
    var otherUserId = UserDefaults.standard.string(forKey: "otherUserId")!
    var body: some View {
        HStack(spacing: 10){
            VStack{
                CustomNavBar(left: {
                    Button(action: {
                        print("Tapped")
                    }, label: {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: self.buttonSize, height: self.buttonSize, alignment: .leading)
                    }).padding()
                }, center: {
                    Text(text.sellerFullName).font(.body).bold()
                    
                    /*
                    AsyncImage(url: imageUrl) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(50)
                                } placeholder: {
                                    ProgressView()
                                }
                    */
                    
                }, right: {
                    HStack {
                        Button("Pay"){
                            isActive = true
                        }.padding(.all)
                            .background(Color("StripeBlueColor"))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .font(Font.body.bold())
                        
                        NavigationLink(destination: ConnectOnboardViewControllerView(), isActive: $isActive) {
                            }
                        }
                    })
                }
            }
        .padding(5)
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow().background(Color("LightBlueColor"))
    }
}

class TitleRowData: ObservableObject {
    @Published var sellerFullName: String  = ""
}
