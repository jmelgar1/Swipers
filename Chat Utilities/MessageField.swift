//
//  MessageField.swift
//  Swipers
//
//  Created by Josh Melgar on 3/2/22.
//

import SwiftUI

struct MessageField: View {
    
    @EnvironmentObject var messagesManager: MessagesManager
    @State private var message = ""
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button {
                messagesManager.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("LightBlueColor"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("GrayColor"))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField().environmentObject(MessagesManager())
    }
}

struct CustomTextField: View {
    var placeholder: Text
    
    //Binding means we can pass a variable from one view to another and modify outside that view
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
