import React from "react"
import PropTypes from "prop-types"
import Team from "./Team"
import I18n from "i18n-js"
import PlayerSelect from "./PlayerSelect"

class Teams extends React.Component {

  constructor (props) {
    super(props)
    this.state = {
      teams: props.teams,
      filter_id: null
    }
  }

  teamList = () => {
    let teamListItems = []
    this.state.teams.forEach( (team, index) => {
      teamListItems.push(<Team key={team.id} data={team} index={index}/>)
    })

    return teamListItems
  }

  filterTeams = (playerId) => {
    let teams = this.props.teams
    if (!isNaN(playerId)) {
      teams = this.props.teams.filter((team) => {
        return team.player1.id === playerId || team.player2.id === playerId
      })
    }
    this.setState({teams: teams})
  }

  render () {
    return (
      <div className='c-team'>
        <span className='c-team-filter-label'>{I18n.t('team.filter_label')}</span>
        <PlayerSelect players={this.props.players} filterTeams={this.filterTeams}/>

        <table width="100%" className="c-team-table">
          <tbody>
            {this.teamList()}
          </tbody>
        </table>
        <p></p>
      </div>
    )
  }
}

Teams.propTypes = {
  teams: PropTypes.array.isRequired,
  players: PropTypes.array.isRequired
}

export default Teams
