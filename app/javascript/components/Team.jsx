import React from 'react'
import I18n from 'i18n-js'

const Team = (props) => {
  return (
    <tr>
      <td><div className="c-team-table-rank">{props.data.rank}</div></td>
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
          { props.data.player2 && <img src={'https://ungif.apps.railslabs.com/ungif?url=' + props.data.player2.image} alt="" /> }
        </div>
      </td>
      <td>
        <div className="c-team-table-player-name">
          { props.data.player2 && props.data.player2.name}
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.wins}</div>
          <div className="c-team-table-label">{I18n.t('common.wins')}</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.losses}</div>
          <div className="c-team-table-label">{I18n.t('common.loses')}</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div>{props.data.quota}%</div>
          <div className="c-team-table-label">{I18n.t('common.quota')}</div>
        </div>
      </td>
      <td>
        <div className="c-team-table-stats">
          <div><b>{props.data.score}</b></div>
          <div className="c-team-table-label"><b>{I18n.t('common.points')}</b></div>
        </div>
      </td>
    </tr>
  )
}

export default Team
