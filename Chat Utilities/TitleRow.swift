//
//  TitleRow.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import SwiftUI

struct TitleRow: View {
    @EnvironmentObject private var text: TitleRowData
    
    //other user imageurl
    var imageUrl = URL(string: UserDefaults.standard.string(forKey: "otherUserImageUrl")!)
    var otherUserId = UserDefaults.standard.string(forKey: "otherUserId")!
    
    var body: some View {
        HStack(spacing: 20){
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading){
                Text(text.sellerFullName).font(.title).bold()
                
                Text("Online").font(.caption).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //Go to payment screen button
            Button(action: {
                
                //will lead to payment screen. will use stripe for payments between users
                print("Button pressed")
            }) {
                Image(systemName: "dollarsign.circle.fill").foregroundColor(.green).padding(-10).background(.white).cornerRadius(50).font(.system(size: 60))
            }
        }
        .padding()
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
