import React from "react"

const PlayerSelect = (props) => {
  const options = props.players.map((player) => {
    return (
      <option key={player.id} value={player.id}>{player.name}</option>
    )
  })

  return (
    <select onChange={(event) => { props.filterTeams(parseInt(event.target.value)) }}>
      <option>All</option>
      {options}
    </select>
  )
}

export default PlayerSelect
