import { useState, useEffect } from 'react'
import './App.css'

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3001'

function App() {
  const [todos, setTodos] = useState([])
  const [newTodo, setNewTodo] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const fetchTodos = async () => {
    try {
      setLoading(true)
      const response = await fetch(`${API_URL}/api/todos`)
      if (!response.ok) throw new Error('Failed to fetch todos')
      const data = await response.json()
      setTodos(data)
      setError(null)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchTodos()
  }, [])

  const addTodo = async (e) => {
    e.preventDefault()
    if (!newTodo.trim()) return

    try {
      const response = await fetch(`${API_URL}/api/todos`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: newTodo })
      })
      if (!response.ok) throw new Error('Failed to add todo')
      const todo = await response.json()
      setTodos([todo, ...todos])
      setNewTodo('')
    } catch (err) {
      setError(err.message)
    }
  }

  const toggleTodo = async (id, completed) => {
    try {
      const response = await fetch(`${API_URL}/api/todos/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ completed: !completed })
      })
      if (!response.ok) throw new Error('Failed to update todo')
      const updatedTodo = await response.json()
      setTodos(todos.map(t => t.id === id ? updatedTodo : t))
    } catch (err) {
      setError(err.message)
    }
  }

  const deleteTodo = async (id) => {
    try {
      const response = await fetch(`${API_URL}/api/todos/${id}`, {
        method: 'DELETE'
      })
      if (!response.ok) throw new Error('Failed to delete todo')
      setTodos(todos.filter(t => t.id !== id))
    } catch (err) {
      setError(err.message)
    }
  }

  return (
    <div className="app">
      <div className="container">
        <h1>📝 Kubernetes Todo App</h1>
        <p className="subtitle">Simple 3-Tier App: React + Node.js + PostgreSQL</p>

        <form onSubmit={addTodo} className="add-form">
          <input
            type="text"
            value={newTodo}
            onChange={(e) => setNewTodo(e.target.value)}
            placeholder="What needs to be done?"
            className="todo-input"
          />
          <button type="submit" className="add-button">Add Todo</button>
        </form>

        {error && (
          <div className="error">
            ❌ Error: {error}
          </div>
        )}

        {loading ? (
          <div className="loading">Loading todos...</div>
        ) : (
          <div className="todos">
            {todos.length === 0 ? (
              <p className="empty">No todos yet. Add one above! 👆</p>
            ) : (
              todos.map(todo => (
                <div key={todo.id} className="todo-item">
                  <input
                    type="checkbox"
                    checked={todo.completed}
                    onChange={() => toggleTodo(todo.id, todo.completed)}
                    className="todo-checkbox"
                  />
                  <span className={todo.completed ? 'completed' : ''}>
                    {todo.title}
                  </span>
                  <button
                    onClick={() => deleteTodo(todo.id)}
                    className="delete-button"
                  >
                    🗑️
                  </button>
                </div>
              ))
            )}
          </div>
        )}

        <div className="stats">
          <span>{todos.filter(t => !t.completed).length} active</span>
          <span>{todos.filter(t => t.completed).length} completed</span>
          <span>{todos.length} total</span>
        </div>
      </div>
    </div>
  )
}

export default App
