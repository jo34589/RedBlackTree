
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
    
    func preorder_traversal() -> [UnsafeMutablePointer<RBnode<T>>] {
        //dfs
        var order:[UnsafeMutablePointer<RBnode<T>>] = []
        
        func dfs(from node: UnsafeMutablePointer<RBnode<T>>?) {
            guard node != nil else {
                return
            }
            order.append(node!)
            dfs(from: node!.pointee.left)
            dfs(from: node!.pointee.right)
        }
        
        dfs(from: root)
        
        return order
    }
    
    func inorder_traversal() -> [UnsafeMutablePointer<RBnode<T>>] {
        
        var order:[UnsafeMutablePointer<RBnode<T>>] = []
        
        func search(from node: UnsafeMutablePointer<RBnode<T>>?) {
            guard node != nil else {
                return
            }
            search(from: node!.pointee.left)
            order.append(node!)
            search(from: node!.pointee.right)
        }
        
        search(from: root)
        
        return order
    }
    
    func postorder_traversal() -> [UnsafeMutablePointer<RBnode<T>>] {
        
        var order:[UnsafeMutablePointer<RBnode<T>>] = []
        
        func search(from node: UnsafeMutablePointer<RBnode<T>>?) {
            guard node != nil else {
                return
            }
            search(from: node!.pointee.left)
            search(from: node!.pointee.right)
            order.append(node!)
        }
        
        search(from: root)
        
        return order
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
    
    mutating func recolor(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool? {
        
        guard let pnode = node.pointee.parent else {
            return nil
        }
        guard let gpnode = pnode.pointee.parent else {
            return nil
        }
        var uncle:UnsafeMutablePointer<RBnode<T>>?
        if gpnode.pointee.left == pnode {
            uncle = gpnode.pointee.right
        } else if gpnode.pointee.right == pnode {
            uncle = gpnode.pointee.left
        }
        pnode.pointee.color = black
        uncle!.pointee.color = black
        gpnode.pointee.color = red
        if gpnode == root {
            gpnode.pointee.color = black
        }
        return true
    }
    
    mutating func restructure(at node: UnsafeMutablePointer<RBnode<T>>) -> Bool? {
        
        guard let pnode = node.pointee.parent else {
            return nil
        }
        guard let gpnode = pnode.pointee.parent else {
            return nil
        }
        if pnode == gpnode.pointee.right && node == pnode.pointee.right {
            //case1: gp <= p <= n
            let zero = gpnode.pointee.parent
            let one = gpnode.pointee.left
            let two = pnode.pointee.left
            let three = node.pointee.left
            let four = node.pointee.right
            
            gpnode.pointee.parent = pnode
            node.pointee.parent = pnode
            pnode.pointee.right = node
            pnode.pointee.left = gpnode
            
            pnode.pointee.parent = zero
            gpnode.pointee.left = one
            gpnode.pointee.right = two
            node.pointee.left = three
            node.pointee.right = four
            
            pnode.pointee.color = black
            gpnode.pointee.color = red
            node.pointee.color = red
            
        } else if pnode == gpnode.pointee.left && node == pnode.pointee.right {
            //caes2: p <= n < gp
            let zero = gpnode.pointee.parent
            let one = pnode.pointee.left
            let two = node.pointee.left
            let three = node.pointee.right
            let four = pnode.pointee.right
            
            node.pointee.right = gpnode
            node.pointee.left = pnode
            pnode.pointee.parent = node
            gpnode.pointee.parent = node
            
            node.pointee.parent = zero
            pnode.pointee.left = one
            pnode.pointee.right = two
            gpnode.pointee.left = three
            gpnode.pointee.right = four
            
            node.pointee.color = black
            pnode.pointee.color = red
            gpnode.pointee.color = red
            
        } else if pnode == gpnode.pointee.right && node == pnode.pointee.left {
            //case3: gp < n <= p
            let zero = gpnode.pointee.parent
            let one = gpnode.pointee.left
            let two = node.pointee.left
            let three = node.pointee.right
            let four = pnode.pointee.right
            
            node.pointee.right = pnode
            node.pointee.left = gpnode
            gpnode.pointee.parent = node
            pnode.pointee.parent = node
            
            node.pointee.parent = zero
            gpnode.pointee.left = one
            gpnode.pointee.right = two
            pnode.pointee.left = three
            pnode.pointee.right = four
            
            node.pointee.color = black
            pnode.pointee.color = red
            gpnode.pointee.color = red
            
        } else if pnode == gpnode.pointee.left && node == pnode.pointee.left {
            //case4: n <= p <= gp
            let zero = gpnode.pointee.parent
            let one = node.pointee.left
            let two = node.pointee.right
            let three = pnode.pointee.right
            let four = gpnode.pointee.right
            
            pnode.pointee.left = node
            pnode.pointee.right = gpnode
            node.pointee.parent = pnode
            gpnode.pointee.parent = pnode
            
            pnode.pointee.parent = zero
            node.pointee.left = one
            node.pointee.right = two
            gpnode.pointee.left = three
            gpnode.pointee.right = four
            
            pnode.pointee.color = black
            node.pointee.color = red
            gpnode.pointee.color = red
            
        } else {
            print("error in restructure")
            return false
        }
        return true
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
         check double red and resolve maybe?
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
         check double red and resolve maybe?
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
    
    func locate(val: T) -> UnsafeMutablePointer<RBnode<T>>? {
        var current = root
        while current != nil {
            if current!.pointee.val == val {
                if current!.pointee.right != nil {
                    if current!.pointee.right!.pointee.val == val {
                        current = current!.pointee.right
                    } else {
                       return current
                    }
                } else {
                    return current
                }
            } else {
                if current!.pointee.val > val {
                    current = current!.pointee.left
                } else if current!.pointee.val < val {
                    current = current!.pointee.right
                }
            }
        }
        return nil
    }
    
    mutating func delete(node: UnsafeMutablePointer<RBnode<T>>) -> UnsafeMutablePointer<RBnode<T>>? {
        
    }
    
    mutating func delete(val: T) -> UnsafeMutablePointer<RBnode<T>>? {
        guard let node_to_del = self.locate(val: val) else {
            return nil
        }
        return delete(node: node_to_del)
    }
    
    func describe() {
        
    }
}
