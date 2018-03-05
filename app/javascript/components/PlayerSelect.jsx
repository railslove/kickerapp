import React from "react"
import I18n from "i18n-js"


const PlayerSelect = (props) => {
  const options = props.players.map((player) => {
    return (
      <option key={player.id} value={player.id}>{player.name}</option>
    )
  })

  return (
    <select onChange={(event) => { props.filterTeams(parseInt(event.target.value)) }}>
      <option>{I18n.t('common.all')}</option>
      {options}
    </select>
  )
}

export default PlayerSelect
