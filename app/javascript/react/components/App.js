import React from 'react'
import { BrowserRouter, Route, Switch } from "react-router-dom"
import PostIndex from "./PostIndex"
export const App = (props) => {
  return (
    <BrowserRouter>
        <Switch>
          <Route exact path="/" component={PostIndex} />
          <Route exact path="/posts" component={PostIndex} />
        </Switch>
    </BrowserRouter>
  )
}

export default App
