import React, { useState, useEffect } from "react"
import PostTile from "./PostTile"
const PostIndex = (props) => {
  const [posts, setPosts] = useState({})
  let postList
  useEffect(() => {
    fetch("/api/v1/posts.json")
    .then (response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage)
        throw error
      }
    })
    .then(response => response.json())
    .then(body => {
      setPosts(body) 
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`))
  }, [])
  if(posts.length > 0){
    postList = posts.map((post) => {
      return(
        <PostTile post={post} />
      )
    })
  }
  
  return (
    <div>
      {postList}
    </div>
  )
}

export default PostIndex