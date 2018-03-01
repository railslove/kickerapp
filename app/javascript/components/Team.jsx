import React from 'react'

const Team = (props) => {
  return (
    <tr>
      <td><div className="c-team-table-rank">{props.index + 1}</div></td>
      <td>
        <div className="c-team-table-player-image">
          <img src={'https://ungif.apps.railslabs.com/ungif?url=' + props.data.player1.image} alt="" />
        </div>
      </td>
      <td>
        <div className="c-team-table-player-name">
          {props.data.player1.name}
        </div>
      </td>
      <td>
        <div className="c-team-table-player-image">
          <img src={'https://ungif.apps.railslabs.com/ungif?url=' + props.data.player2.image} alt="" />
        </div>
      </td>
      <td>
        <div className="c-team-table-player-name">
          {props.data.player2.name}
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.wins}</div>
          <div className="c-team-table-label">Siege</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.losses}</div>
          <div className="c-team-table-label">Niederlagen</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.quota}%</div>
          <div className="c-team-table-label">Quote</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div><b>{props.data.score}</b></div>
          <div className="c-team-table-label"><b>Punkte</b></div>
        </div>
      </td>
    </tr>
  )
}

export default Team
