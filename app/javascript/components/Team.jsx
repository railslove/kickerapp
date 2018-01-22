import React from "react"

const Team = (props) => {
  return (
    <div>{props.data.name} <b>{props.data.score}</b></div>
  )
}

export default Team
