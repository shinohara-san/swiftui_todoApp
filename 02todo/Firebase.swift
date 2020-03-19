import Foundation
import FirebaseFirestore

//Firebaseのみ読み書きはここ
struct todoDataType: Identifiable, Equatable {
    var id: String
    var todo: String
}

class TodoViewModel: ObservableObject {
    @Published var todos = [todoDataType]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("todos").order(by: "date", descending: true).addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges{
                    if i.type == .added {
                        let id = i.document.documentID
                        let todo = i.document.get("todo") as! String
                        self.todos.append(todoDataType(id: id, todo: todo))
                    }
                    
                    if i.type == .removed {
                        let todo = i.document.get("todo") as! String
                        let id = i.document.documentID
                        
                        if let index = self.todos.firstIndex(of: todoDataType(id: id, todo: todo)){
                        self.todos.remove(at: index)
                        }
                    }
                }
            }
        }
    }
    
    func deleteMessage(deleteId: String){
        let db = Firestore.firestore()
            db.collection("todos").document(deleteId).delete(){ error in
                   if let error = error {
                       print(error.localizedDescription)
                       return
                   }
                   print("delete success")
               }
        
    }
    
    func addMessage(todo: String){
        let data = [
            "todo": todo,
            "date": Date()
            ] as [String : Any]
        
        let db = Firestore.firestore()
               db.collection("todos").addDocument(data: data){ error in
                   if let error = error {
                       print(error.localizedDescription)
                       return
                   }
                   print("success")
               }
        
    }
}
