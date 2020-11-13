//
//  EditView.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 29/10/2020.
//

import SwiftUI

struct EditView: View {
    
    //    @State var note : NoteModel = NoteModel()
    var note : FetchedResults<PhoneNote>.Element
    //    var id: UUID
    //    var contactName: String
    //    var fromWho: Caller
    //    var dayToCall: NoteDate
    //    var timestamp: Date
    //    var telephone: PhoneNumber
    //    var note: String?
    static var noteComments:String = ""
    static var noteCommentsBinding = Binding<String>(get: { noteComments }, set: { noteComments = $0 } )
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Add Note").font(.system(.title, design: .rounded))
                Form{
                    NoteContactView(note: note)
                    NoteTypeView(note: note)
                    MultilineTextField("Type here", text: EditView.noteCommentsBinding, onCommit: {
                        print("Final text: \(EditView.noteComments)")
                    })
                    DateToCallView(note: note)
                }
            }
        }
    }
}
struct NoteContactView: View {
    
    var note : FetchedResults<PhoneNote>.Element
    @State var name : String = ""
    var body: some View {
        HStack{
            Text(LocalizedStringKey("Name"))
            Spacer()
            TextField(LocalizedStringKey("Name"), text: self.$name).padding(.leading).keyboardType(.default).multilineTextAlignment(.trailing)
        }.onAppear{
            self.name = self.note.contactName ?? ""
        }
    }
}

struct NoteTypeView: View {
    
    
    @State var noteTypeText : String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    var note : FetchedResults<PhoneNote>.Element
    @State private var noteCaller : Caller = Caller.family
    
    private var noteTypeClicker:Binding<Caller> {
        Binding<Caller>(get: {self.noteCaller }, set: {
            self.noteCaller = $0
            self.note.fromWho = self.noteCaller.rawValue
        })
    }
    
    var body: some View {
        HStack {
            
            Picker(LocalizedStringKey("Tipo"), selection: noteTypeClicker) {
                ForEach(Caller.allCases, id:\.self){ noteCaller in
                    HStack{
                        Circle()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(Color.white)
                            .overlay(
                                Image(systemName: noteCaller.icon)
                                    .frame(width: 35, height: 35, alignment: .center)
                                    .foregroundColor(noteCaller.color)
                                    .font(.system(size: 20)))
                            .scaledToFit()
                        Text(noteCaller.description)
                    }
                }
                
            }.onAppear{
                self.noteCaller = note.caller
            }
        }
    }
}

struct MultilineTextField: View {
    
    private var placeholder: String
    private var onCommit: (() -> Void)?
    @State private var viewHeight: CGFloat = 40 //start with one line
    @State private var shouldShowPlaceholder = false
    @Binding private var text: String
    
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.shouldShowPlaceholder = $0.isEmpty
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "doc.plaintext")
                    .frame(width: 35, height: 35, alignment: .center)
                    .font(.system(size: 20))
                .foregroundColor(Color("TextColor"))
            }
            UITextViewWrapper(text: self.internalText, calculatedHeight: $viewHeight, onDone: onCommit)
            .frame(minHeight: viewHeight, maxHeight: viewHeight)
            .background(placeholderView, alignment: .topLeading)
        }
    }
    
    var placeholderView: some View {
        Group {
            if shouldShowPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
    
    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._shouldShowPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }
    
}

struct DateToCallView: View {
    
    @State private var date = NoteDate(date: Date())
    @Environment(\.managedObjectContext) private var viewContext
    var note : FetchedResults<PhoneNote>.Element
    
    private var datePicker:Binding<NoteDate> {
        
        Binding<NoteDate>(get: {self.date }, set: {
            self.date = $0
            
            note.dayToCallModel = self.date
            note.daytoCall = note.dayToCallModel.completeDate
        })
        
    }
    
    
    var body: some View {
        VStack{
            HStack {
                DatePicker(LocalizedStringKey("Day to Call"), selection: datePicker.completeDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                //                    .scaledToFit()
                
            }
        }.onAppear(perform: {
           
            self.date = note.dayToCallModel
           
        })
        
    }
}
//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
