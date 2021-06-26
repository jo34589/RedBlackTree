
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
    
    func check_uncle_color(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool? {
        guard let pnode = node.pointee.parent else {
            return nil
        }
        guard let gpnode = pnode.pointee.parent else {
            return nil
        }
        if gpnode.pointee.left == pnode {
            if gpnode.pointee.right == nil {
                return black
            } else {
                return gpnode.pointee.right!.pointee.color
            }
        } else {
            if gpnode.pointee.left == nil {
                return black
            } else {
                return gpnode.pointee.left!.pointee.color
            }
        }
    }
    
    mutating func recolor(at node: UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func restructure(at node: UnsafeMutablePointer<RBnode<T>>) {
        
    }
    
    mutating func rotate_left(at node:UnsafeMutablePointer<RBnode<T>>) -> Bool {
        guard let rnode = node.pointee.right else {
            return false
        }
        rnode.pointee.parent = node.pointee.parent
        node.pointee.parent = rnode
        if let lnode = rnode.pointee.left {
            lnode.pointee.parent = node
            node.pointee.right = lnode
        } else {
            node.pointee.right = nil
        }
        rnode.pointee.left = node
        /*
         check double red and resolve
         */
        return true
    }
    
    mutating func rotate_right(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool {
        guard let lnode = node.pointee.left else {
            return false
        }
        lnode.pointee.parent = node.pointee.parent
        node.pointee.parent = lnode
        if let rnode = lnode.pointee.right {
            rnode.pointee.parent = node
            node.pointee.left = rnode
        } else {
            node.pointee.left = nil
        }
        lnode.pointee.right = node
        /*
         check double red and resolve
         */
        return true
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
                //node.pointee.val >= current.pointee.val
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
            //check uncld and resolve double red
        }
        
        return true
    }
    
    mutating func insert(val: T) -> Bool {
        var node = RBnode<T>(val: val)
        return insert(node: &node)
    }
    
    func find(val: Int) -> UnsafeMutablePointer<RBnode<T>>? {
        
    }
    
    mutating func delete(node: UnsafeMutablePointer<RBnode<T>>) -> UnsafeMutablePointer<RBnode<T>>? {
        
    }
    
    mutating func delete(val: Int) -> UnsafeMutablePointer<RBnode<T>>? {
        guard let node_to_del = self.find(val: val) else {
            return nil
        }
        return delete(node: node_to_del)
    }
    
    func get_val(node: UnsafeMutablePointer<RBnode<T>>) -> T {
        
    }
    
    mutating func change_val(of node: UnsafeMutablePointer<RBnode<T>>, to val: T) -> Bool {
        
    }
    
    func visualize() {
        
    }
}
