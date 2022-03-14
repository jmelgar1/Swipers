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
    
    let buttonSize: CGFloat = 30
    
    //other user imageurl
    var imageUrl = URL(string: UserDefaults.standard.string(forKey: "otherUserImageUrl")!)
    var otherUserId = UserDefaults.standard.string(forKey: "otherUserId")!
    var body: some View {
        HStack(spacing: 10){
            VStack{
                CustomNavBar(left: {
                    Button("<"){
                        isActive = true
                    }.padding(.all)
                        .background(Color("StripeBlueColor"))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .font(Font.body.bold())
                    
                    NavigationLink(destination: SFSControllerView(), isActive: $isActive) {
                        }
                }, center: {
                    Text(text.sellerFullName).font(.body).bold()
                }, right: {
                    HStack {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .cornerRadius(50)
                            } placeholder: {
                                ProgressView()
                        }

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
