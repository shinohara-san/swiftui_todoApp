import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @State var todo = ""
    @ObservedObject var todoVM = TodoViewModel()
    
    var body: some View {
//        NavigationView{
             VStack {
                        Text("Firebase Todo App")
//                ScrollView{
                        List{
                            ForEach(todoVM.todos, id: \.id) { i in
                                todoView(todo: i.todo, idToDelete: i.id)
                            }
                        }
//                }
                        Spacer()
                        HStack {
                            TextField("todoを入力", text: $todo).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 300.0)
                            
                            Button(action: {
                                self.todoVM.addMessage(todo: self.todo)
                                self.todo = ""
                            }) {
                                Image(systemName: "paperplane").scaleEffect(1.4).padding(.horizontal).foregroundColor(.black)
                            }
                            
                        }
                    }
//        }
       
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

