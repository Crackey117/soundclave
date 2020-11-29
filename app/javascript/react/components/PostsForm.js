import React, { useState } from 'react'
import _ from 'lodash'
import ErrorList from './ErrorList'

const PostsForm = (props) => {

  const [submittedPost, setSubmittedPost] = useState({
    body: ""
  })
  const [errors, setErrors] = useState({})
  const [error, setError] = useState(null)

  const validforSubmission = () => {
    let submittedErrors = {}
    const requiredFields = ["body"]
    requiredFields.forEach(field => {
      if (submittedPost[field].trim() === "") {
        submittedErrors = {
          ...submittedErrors,
          [field]: "is blank"
        }
      }
    })
    setErrors(submittedErrors)
    return _.isEmpty(submittedErrors)
  }

  const inputChangeHandler = (event) => {
    setSubmittedPost({
      ...submittedPost,
      [event.currentTarget.name]: event.currentTarget.value
    })
  }

  const onClickHandler = (event) => {
    event.preventDefault()
    if (validforSubmission()) {
      fetch(`/api/v1/posts.json`, {
        method: "POST",
        body: JSON.stringify(submittedPost),
        credentials: "same-origin",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
      })
      .then(response => response.json())
      .then(body => {
        if (body.errors) {
          const requiredFields = ["body"]
          requiredFields.forEach(field => { 
            if (body.errors[field] !== undefined) {
              setErrors({
                ...errors,
                [field]: body.errors[field][0]
              })
            }
          })
        }else if (body.error) {
          setError(body.error)
        }else{
          props.setPosts(body)
        }
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`))
    }
  }

  return(
    <div>
      <div>
        <p>What's on your mind?</p>
      </div>
      <ErrorList errors={errors}
          error={error} />
      <div>
        <form onSubmit={onClickHandler}>
          

          <label>
            Thoughts
            <input 
              name="body"
              id="body"
              type="text"
              onChange={inputChangeHandler}
              value={submittedPost.body}
              />
          </label>

         
          <div>
            <input
              type="submit"
              value="Add your thoughts"
            />
          </div>
      </form>
      </div>
    </div>
  )
}

export default PostsForm