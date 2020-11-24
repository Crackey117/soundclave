import React from "react"

const PostTile = (props) => {
  return(
    <div>
      <p>{props.post.body}</p>
      <p>{props.post.user.username}</p>
    </div>
  )
}

export default PostTile 