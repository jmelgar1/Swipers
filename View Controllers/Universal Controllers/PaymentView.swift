//
//  PaymentView.swift
//  Swipers
//
//  Created by Josh Melgar on 3/5/22.
//

import SwiftUI

struct PaymentView: View {
    
    @Binding var presentedAsModal: Bool
    
    var body: some View {
        Button("Go back") { self.presentedAsModal = false }
    }
}
/*
struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
*/
