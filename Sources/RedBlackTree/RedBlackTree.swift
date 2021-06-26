
import Foundation

let red = false
let black = true

struct RBnode<T: Comparable> {
    
    var val:T
    var color:Bool = red
    var depth = 0
    var parent:UnsafeMutablePointer<RBnode<T>>?
    var left:UnsafeMutablePointer<RBnode<T>>?
    var right:UnsafeMutablePointer<RBnode<T>>?
    
    mutating func change_val(val: T) {
        self.val = val
    }
}

struct RBtree<T: Comparable> {
    
    var root:UnsafeMutablePointer<RBnode<T>>?
    var size:Int = 0
    
    func isEmpty() -> Bool {
        if size == 0 {
            return true
        } else {
            return false
        }
    }
    
    func count() -> Int {
        return size
    }
    
    func max_node() -> UnsafeMutablePointer<RBnode<T>>? {
        guard !isEmpty() else {
            return nil
        }
        var current = root!
        while current.pointee.right != nil {
            current = current.pointee.right!
        }
        return current
    }
    
    func min_node() -> UnsafeMutablePointer<RBnode<T>>? {
        guard !isEmpty() else {
            return nil
        }
        var current = root!
        while current.pointee.left != nil {
            current = current.pointee.left!
        }
        return current
    }
    
    func max_val() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return max_node()!.pointee.val
    }
    
    func min_val() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return min_node()!.pointee.val
    }
    
    func check_doublered(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool {
        guard let pnode = node.pointee.parent else {
            return false
        }
        if node.pointee.color == red && pnode.pointee.color == red {
            return true
        } else {
            return false
        }
    }
    
    func check_uncle_color(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool {
        
    }
    
    mutating func rotate_left(at node:UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func rotate_right(at node: UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func recolor(at node: UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func restructure(at node: UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func insert(node: UnsafeMutablePointer<RBnode<T>>) -> Bool {
        guard !self.isEmpty() else {
            root = node
            size += 1
            root!.pointee.color = black
            root!.pointee.depth = 1
            return true
        }
        var depth = 0
        var current = root!
        while node.pointee.parent == nil {
            if node.pointee.val < current.pointee.val {
                depth += 1
                if current.pointee.left != nil {
                    current = current.pointee.left!
                } else {
                    node.pointee.parent = current
                    node.pointee.depth = depth
                    current.pointee.left = node
                }
            } else {
                depth += 1
                if current.pointee.right != nil {
                    current = current.pointee.right!
                } else {
                    node.pointee.parent = current
                    node.pointee.depth = depth
                    current.pointee.right = node
                }
            }
        }
        
        current = node
        while !check_doublered(at: current) {
            
        }
        
        return true
    }
    
    mutating func insert(val: T) -> Bool {
        var node = RBnode<T>(val: val)
        return insert(node: &node)
    }
    
    mutating func delete(node: UnsafeMutablePointer<RBnode<T>>) -> UnsafeMutablePointer<RBnode<T>> {
        
    }
    
    mutating func delete(val: Int) -> Bool {
        
    }
    
    func find(val: Int) -> UnsafeMutablePointer<RBnode<T>> {
        
    }
    
    func get_val(node: UnsafeMutablePointer<RBnode<T>>) -> T {
        
    }
    
    mutating func change_val(of node: UnsafeMutablePointer<RBnode<T>>, to val: T) -> Bool {
        
    }
    
    func visualize() {
        
    }
}
