# Linear data structures

class Stack
  constructor: ->
    @_arr = []
  push: (item) ->
    @_arr.push item
  pop: ->
    @_arr.pop()
  peep: ->
    @_arr[@_arr.length-1]
  isEmpty: ->
    @_arr.length is 0
  size: ->
    @_arr.length

class Queue
  constructor: ->
    @_arr = []
  enqueue: (item) ->
    @_arr.unshift item
  dequeue: ->
    @_arr.shift()
  isEmpty: ->
    @_arr.length is 0
  size: ->
    @_arr.length

class Dequeue
  constructor: ->
    @_arr = []
  addFront: (item) ->
    @_arr.unshift item
  addRear: (item) ->
    @_arr.push item
  removeFront: ->
    @_arr.shift()
  removeRear: ->
    @_arr.pop()
  isEmpty: ->
    @_arr.length is 0
  size: ->
    @_arr.length

class ListItem
  constructor: (@data) ->
    @next = null
  getData: ->
    @data
  getNext: ->
    @next
  setData: (data) ->
    @data = data
  setNext: (next) ->
    @next = next

class UnorderedList
  constructor: ->
    @head = null
  isEmpty: ->
    @head is null
  add: (item) ->
    listItem = new ListItem item
    listItem.setNext @head
    @head = listItem
  size: ->
    current = @head
    count = 0
    until current is null
      count++
      current = current.getNext()
    count
  search: (item) ->
    current = @head
    found = false
    while current isnt null and not found
      if current.getData() is item
        found = true
      else
        current = current.getNext()
    found
  # Assumes item exists in list
  remove: (item) ->
    current = @head
    previous = null
    found = false
    until found
      if current.getData() is item
        found = true
      else
        previous = current
        current = current.getNext()
    if previous is null
      @head = current.getNext()
    else
      previous.setNext current.getNext()
  append: (item) ->
    current = @head
    next = current.getNext()
    until next is null
      current = next
      next = current.getNext()
    listItem = new ListItem item
    current.setNext listItem
  # Assumes item is in list
  index: (item) ->
    current = @head
    count = -1
    found = false
    until found
      count++
      if current.getData() is item
        found = true
      else
        current = current.getNext()
    if found then count else -1
  # Assumes list is long enough
  insert: (pos, item) ->
    current = @head
    previous = null
    if pos isnt 0
      for i in [1..pos]
        previous = current
        current = current.getNext()
    listItem = new ListItem item
    if previous is null
      @head = itemNode
      listItem.setNext current
    else
      previous.setNext listItem
      listItem.setNext current
  # Assumes item is in list
  pop: (pos) ->
    pos ?= @size() - 1
    current = @head
    previous = null
    if pos isnt 0
      for i in [1..pos]
        previous = current
        current = current.getNext()
    if previous is null
      @head = null
    else
      previous.setNext current.getNext()
    current.getData()
 
class OrderedList
  constructor: ->
    @head = null
  isEmpty: ->
    @head is null
  size: ->
    current = @head
    count = 0
    until current is null
      count++
      current = current.getNext()
    count
  add: (item) ->
    current = @head
    previous = null
    stop = false
    while current isnt null and not stop
      if current.getData() > item
        stop = true
      else
        previous = current
        current = current.getNext()
    listItem = new ListItem item
    if previous is null
      listItem.setNext @head
      @head = listItem
    else
      listItem.setNext current
      previous.setNext listItem
   search: (item) ->
    current = @head
    found = false
    stop = false
    while current isnt null and not found and not stop
      if current.getData() is item
        found = true
      else
        if current.getData() > item
          stop = true
        else
          current = current.getNext()
    found
  # Assumes item exists in list
  remove: (item) ->
    current = @head
    previous = null
    found = false
    until found
      if current.getData() is item
        found = true
      else
        previous = current
        current = current.getNext()
    if previous is null
      @head = current.getNext()
    else
      previous.setNext current.getNext()
  # Assumes item is in list
  index: (item) ->
    current = @head
    count = -1
    found = false
    until found
      count++
      if current.getData() is item
        found = true
      else
        current = current.getNext()
    if found then count else -1
  # Assumes item is in list
  pop: (pos) ->
    pos ?= @size() - 1
    current = @head
    previous = null
    if pos isnt 0
      for i in [1..pos]
        previous = current
        current = current.getNext()
    if previous is null
      @head = null
    else
      previous.setNext current.getNext()
    current.getData()

# Map

class Map
  constructor: ->
    @_obj = {}
  put: (key, item) ->
    @_obj[key] = item
  get: (key) ->
    if key in @_obj then @_obj[key] else null
  delete: (key) ->
    delete @_obj[key]
  size: ->
    count = 0
    for own key of @_obj
      count++
    count
  exists: (key) ->
    key in @_obj

# Branching data structures

class BinaryTree
  constructor: (@key) ->
    @leftChild = null
    @rightChild = null
  getLeftChild: ->
    @leftChild
  getRightChild: ->
    @rightChild
  setRootVal: (val) ->
    @key = val
  getRootVal: ->
    @key
  insertLeft: (val) ->
    if @leftChild is null
      @leftChild = new BinaryTree val
    else
      t = new BinaryTree val
      t.leftChild = @leftChild
      @leftChild = t
  insertRight: (val) ->
    if @rightChild is null
      @rightChild = new BinaryTree val
    else
      t = new BinaryTree val
      t.rightChild = @rightChild
      @rightChild = t

class BinaryHeap
  constructor: ->
    @_list = [0]
    @size = 0
  _percolateUp: (i) ->
    while Math.floor(i / 2) > 0
      if @_list[i] < @_list[Math.floor(i / 2)]
        temp = @_list[Math.floor(i / 2)]
        @_list[Math.floor(i / 2)] = @_list[i]
        @_list[i] = temp
      i = Math.floor(i / 2)
  insert: (k) ->
    @_list.append k
    @size++
    @_percolateUp @size
  findMin: ->
    @_list[0]
  @_minChild = (i) ->
    if i * 2 + 1 > @size
      i * 2
    else
      if @_list[i * 2] < @_list[i * 2 + 1]
        i * 2
      else
        i * 2 + 1
  @_percolateDown: (i) ->
    while i * 2 <= @_size
      mc = @_minChild i
      if @_list[i] > @_list[mc]
        temp = @_list[i]
        @_list[i] = @_list[mc]
        @_list[mc] = temp
      i = mc
  deleteMin: ->
    returnVal = @_list[1]
    @_list[1] = @_list[@_size]
    @size--
    @_list.pop()
    @_percolateDown i
    returnVal
  isEmpty: ->
    @size is 0
  buildHeap: (list) ->
    i = Math.floor(list.length / 2)
    @size = list.length
    @_list = [0].concat list
    while i > 0
      @_percolateDown i
      i--

class BinaryNode
  constructor: (@key, @val, @leftChild=null, @rightChild=null, @parent=null) ->
  hasLeftChild: ->
    @leftChild
  hasRightChild: ->
    @rightChild
  isLeftChild: ->
    @parent?.leftChild is @
  isRightChild: ->
    @parent?.rightChild is @
  isRoot: ->
    !@parent?
  isLeaf: ->
    !(@leftChild or @ @rightChild)
  hasAnyChildren: ->
    @leftChild or @rightChild
  hasBothChildren: ->
    @leftChild and @rightChild
  replaceNodeData: (key, val, lc, rc) ->
    @key = key
    @val = val
    @leftChild = lc
    @rightChild = rc
    if @hasLeftChild()
      @leftChild.parent = @
    if @hasRightChild()
      @rightChild.parent = @

class BinarySearchTree
  constructor: ->
    @_root = null
    @size = 0
  length: ->
    @size
  # Cannot deal with duplicates
  _put: (key, val, currentNode) ->
    if key < currentNode.key
      if currentNode.hasLeftChild()
        @_put key, val, currentNode.leftChild
      else
        currentNode.leftChild = new BinaryNode key, val, null, null, currentNode
    else
      if currentNode.hasRightChild()
        @_put key, val, currentNode.rightChild
      else
        currentNode.rightChild = new BinaryNode key, val, null, null, currentNode
  put: (key, val) ->
    if @root
      @_put key, val, @root
    else
      @root = new BinaryNode key, val
    @size++
  _get: (key, currentNode) ->
    unless currentNode
      null
    else if currentNode.key is key
      currentNode
    else if key < currentNode.key
      @_get key, currentNode.leftChild
    else
      @_get key, currentNode.rightChild
  get: (key) ->
    if @root
      result = @_get key, @root
      if result then @result.val else null
    else
      null
  delete: (key) ->
    if @size > 1
      nodeToRemove = @_get key, @root
      if nodeToRemove
        @remove nodeToRemove
        @size--
      else
        throw new Error "Key not in tree"
    else if @size is 1 and @root.key is key
      @root = null
      @size--
    else
      throw new Error "Key not in tree"
  spliceOut: ->
    if @isLeaf()
      if @isLeftChild()
        @parent.leftChild = null
      else
        @parent.rightChild = null
    else if @hasAnyChildren()
      if @hasLeftChild()
        if @isLeftChild()
          @parent.leftChild = @leftChild
        else
          @parent.rightChild = @leftChild
        @leftChild.parent = @parent
      else
        if @isLeftChild()
          @parent.leftChild = @rightChild
        else
          @parent.rightChild = @rightChild
        @rightChild.parent = @parent
  findSuccessor: ->
    succ = null
    if @hasRightChild()
      succ = @rightChild.findMin()
    else
      if @parent
        if @isLeftChild()
          succ = @parent
        else
          @parent.rightChild = null
          succ = @parent.findSuccessor()
    succ
  findMin: ->
    current = @
    while current.hasLeftChild()
      current = current.leftChild
    current
  remove: (currentNode) ->
    if currentNode.isLeaf()
      if currentNode is currentNode.parent.leftChild
        currentNode.parent.leftChild = null
      else
        currentNode.parent.rightChild = null
    else if currentNode.hasBothChildren()
      succ = currentNode.findSuccessor()
      succ.spliceOut()
      currentNode.key = succ.key
      currentNode.val = succ.val
    else
      if currentNode.hasLeftChild()
        if currentNode.isLeftChild()
          currentNode.leftChild.parent = currentNode.parent
          currentNode.parent.leftChild = currentNode.leftChild
        else if currentNode.isRightChild()
          currentNode.leftChild.parent = currentNode.parent
          currentNode.parent.rightChild = currentNode.leftChild
        else
          currentNode.replaceNodeData currentNode.leftChild.key, currentNode.leftChild.val, currentNode.leftChild.leftChild, currentNode.leftChild.rightChild
      else
        if currentNode.isLeftChild()
          currentNode.rightChild.parent = currentNode.parent
          currentNode.parent.leftChild = currentNode.rightChild
        else if currentNode.isRightChild()
          currentNode.rightChild.parent = currentNode.parent
          currentNode.parent.rightChild = currentNode.rightChild
        else
          currentNode.replaceNodeData currentNode.rightChild.key, currentNode.rightChild.val, currentNode.rightChild.leftChild, currentNode.rightChild.rightChild

class AVLTree extends BinarySearchTree
  _put: (key, val, currentNode) ->
    if key < currentNode.key
      if currentNode.hasLeftChild()
        @_put key, val, currentNode.leftChild
      else
        currentNode.leftChild = new BinaryNode key, val, null, null, currentNode
        @updateBalanace currentNode.leftChild
    else
      if currentNode.hasRightChild()
        @_put key, val, currentNode.rightChild
      else
        currentNode.rightChild = new BinaryNode key, val, null, null, currentNode
        @updateBalance currentNode.rightChild
  updateBalance: (node) ->
    if node.balanceFactor > 1 or node.balanceFactor < -1
      @rebalance node
      return
    if node.parent isnt null
      if node.isLeftChild()
        node.parent.balanceFactor += 1
      else if node.isRightChild()
        node.parent.balanceFactor -= 1
      if node.parent.balanceFactor != 0
        @updateBalance node.parent
  rotateLeft: (rotRoot) ->
    newRoot = rotRoot.rightChild
    rotRoot.rightChild = newRoot.leftChild
    unless newRoot.leftChild is null
      newRoot.leftChild.parent = rotRoot
    newRoot.parent = rotRoot.parent
    if rotRoot.isRoot()
      @root = newRoot
    else
      if rotRoot.isLeftChild()
        rotRoot.parent.leftChild = newRoot
      else
        rotRoot.parent.rightChild = newRoot
    newRoot.leftChild = rotRoot
    rotRoot.parent = newRoot
    rotRoot.balanceFactor += 1 - Math.min newRoot.balanceFactor, 0
    newRoot.balanceFactor += 1 + Math.max rotRoot.balanceFactor, 0
  rotateRight: (rotRoot) ->
    newRoot = rotRoot.leftChild
    rotRoot.leftChild = newRoot.rightChild
    unless newRoot.rightChild is null
      newRoot.rightChild.parent = rotRoot
    newRoot.parent = rotRoot.parent
    if rotRoot.isRoot()
      @root = newRoot
    else
      if rotRoot.isRightChild()
        rotRoot.parent.rightChild = newRoot
      else
        rotRoot.parent.leftChild = newRoot
    newRoot.rightChild = rotRoot
    rotRoot.parent = newRoot
    rotRoot.balanceFactor += 1 - Math.min newRoot.balanceFactor, 0
    newRoot.balanceFactor += 1 + Math.max rotRoot.balanceFactor, 0
  rebalance: (node) ->
    if node.balanceFactor < 0
      if node.rightChild.balanceFactor > 0
        @rotateRight node.rightChild
      @rotateLeft node
    else if node.balanceFactor > 0
      if node.leftChild.balanceFactor < 0
        @rotateLeft node.leftChild
      @rotateRight node
  # TODO deletion

class Graph



class Set
  # union, intersection, difference, issubset, add, remove, pop, clear
  constructor: ->
