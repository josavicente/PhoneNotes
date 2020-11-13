//
//  ContentView.swift
//  PhoneNotes
//
//  Created by Josafat Vicente Pérez on 23/09/2020.
//

import SwiftUI
import CoreData
import HapticEngine

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var haptics: HapticEngine
    @State var showAdd : Bool = false
    @EnvironmentObject var appState: AppState
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PhoneNote.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<PhoneNote>
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color("Background").ignoresSafeArea()
                VStack{
                    List{
                        ForEach(items) { item in
                            CompleteView(item: item)
                            .padding(10).listRowInsets(EdgeInsets())
                            .background(Color("BackgroundCell"))
                        }.onDelete(perform: deleteItems)
                        
                        
                    }.listStyle(InsetGroupedListStyle())
                    .background(Color("Background"))
                    
                }
            }
//            NavigationLink(destination: AddView(), isActive: $appState.showActionSheet){
//            }
            .navigationTitle(LocalizedStringKey("Notas")).foregroundColor(.black)
            .navigationBarItems( leading:
                                    Button(action: {
                                    }, label: {
                                        Label("Info", systemImage: "info.circle.fill")
                                    }),
                                 trailing:
                                    Button(action: {
                                        haptics.simpleSuccess()
                                        self.showAdd.toggle()
                                        addItem()
                                    }, label: {
                                        Label("Add Item", systemImage: "plus")
                                        
                                    })
            )
            
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
            Button(action: addItem) {
                Label("Info", systemImage: "info.circle.fill")
            }
            
        }
    }

    private func addItem() {
        withAnimation {
            
            let newItem = PhoneNote(context: viewContext)
            newItem.contactName = "Name "
            newItem.telephone = "Telephont "
            newItem.note = "Extensive Note about the call, Extensive Note about the call, Extensive Note about the call, Extensive Note about the call, Extensive Note about the call"
            newItem.fromWho = Caller.unknown.rawValue
            newItem.timestamp = Date()
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CompleteView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
//    var item: FetchedResults<PhoneNote>.Element
    @EnvironmentObject private var haptics: HapticEngine
    @ObservedObject var item: PhoneNote
    @State var showModal : Bool = false
    
    var body: some View {
        HStack(alignment: .top){
            Image(systemName: item.caller.icon).foregroundColor(item.caller.color)
                .font(.system(.title))
            
            VStack{
                HStack {
                    Text(item.contactName ?? "Empty")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack{
                    Text(item.note ?? "Empty")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    Spacer()
                }
                HStack{
                    Text(item.timestamp?.dateToString(date: item.timestamp!) ?? "Empty")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            Spacer()
            
            Button(action: {
            }) {
                Image(systemName:"phone.circle.fill")
                    .font(.system(.title))
                    .foregroundColor(Color.purple)
            }.buttonStyle(PlainButtonStyle())
            
        }.onTapGesture{
            haptics.simpleSuccess()
            self.showModal.toggle()
        }
        .sheet(isPresented: self.$showModal , onDismiss: {
        })
        {
           EditView(note: item)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
