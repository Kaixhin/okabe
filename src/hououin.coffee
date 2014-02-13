_ = require "lodash"

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

class Set
  # union, intersection, difference, issubset, add, remove, pop, clear
  constructor: ->

class Tree

class Graph
