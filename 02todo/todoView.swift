import SwiftUI
import FirebaseFirestore

struct todoView: View {
    
    var todo = ""
    var idToDelete = ""
    @ObservedObject var todoVM = TodoViewModel()
    
    var body: some View {
        HStack {
            Text(todo).padding(.leading)
            
            Spacer()
            
            Button(action: {
                self.todoVM.deleteMessage(deleteId: self.idToDelete)
            }) {
                Image(systemName: "trash").scaleEffect(1.4).foregroundColor(.blue)
            }.padding(.trailing)
            
        }

        
    }
}

struct todoView_Previews: PreviewProvider {
    static var previews: some View {
        todoView(todo: "running", idToDelete: "aaaa")
    }
}
