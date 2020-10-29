//
//  AddView.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 29/10/2020.
//

import SwiftUI

struct AddView: View {
    
    @State var note : NoteModel = NoteModel()
    
    //    var id: UUID
    //    var contactName: String
    //    var fromWho: Caller
    //    var dayToCall: NoteDate
    //    var timestamp: Date
    //    var telephone: PhoneNumber
    //    var note: String?
    
    var body: some View {
        VStack{
            Text("Add Note").font(.system(.title, design: .rounded))
            Form{
                HStack{
                    Text(LocalizedStringKey("Name"))
                    Spacer()
                    TextField(LocalizedStringKey("Name"), text: self.$note.contactName).padding(.leading).keyboardType(.default).multilineTextAlignment(.trailing)
                }
                HStack{
                    Text(LocalizedStringKey("Name"))
                    Spacer()
                    TextField(LocalizedStringKey("Name"), text: self.$note.contactName).padding(.leading).keyboardType(.default).multilineTextAlignment(.trailing)
                }
            }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
