import React, { useState, useEffect } from "react"
import PostTile from "./PostTile"
import PostsForm from "./PostsForm"
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
      setPosts(body.post_items) 
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
  const setNewPosts = (newPost) => {
    setPosts([
      ...posts,
      newPost
    ])
  }
  
  return (
    <div>
      {postList}
      <PostsForm setPosts={setNewPosts}/>
    </div>
  )
}

export default PostIndex