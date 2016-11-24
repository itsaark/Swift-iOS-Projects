//: Creating  a Linked List

public class Node<T>{
    
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

public class LinkedList<T>{
    
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    public var isEmpty: Bool{
        return head == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func append(value: T) {
        
        let newNode = Node(value: value)
        
        if let tailNode = tail{
            newNode.previous = tailNode
            tailNode.next = newNode
            
        }else{
            head = newNode
        }
        
        tail = newNode
        
    }
}

extension LinkedList: CustomStringConvertible{
    
    public var description: String{
        
        var text = "["
        var node = head
        
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil {text += ", "}
        }
        
        return text + "]"
    }
}

