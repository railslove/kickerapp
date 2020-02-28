# frozen_string_literal: true

module Subscriptions
  class PushPebbleTimelinePin
    def subscribe!
      # ActiveSupport::Notifications.subscribe(/match:(created|updated)/, self)
    end

    def call(_event_name, payload)
      match = payload[:record]

      pins = PebbleTimeline::Pins.new

      pin = {
        topics: match.league.slug,
        time: match.date.iso8601,
        layout: {
          type: 'sportsPin',
          title: "#{match.winner_team.short_name} vs #{match.loser_team.short_name} | #{match.score}",
          subtitle: match.league.name,
          tinyIcon: 'system://images/SOCCER_GAME',
          largeIcon: 'system://images/SOCCER_GAME',
          nameHome: match.loser_team.short_name,
          nameAway: match.winner_team.short_name,
          scoreHome: match.scores.second.to_s,
          scoreAway: match.scores.first.to_s,
          sportsGameState: 'in-game',
          body: "#{match.winner_team.name}\n\n#{match.loser_team.name}"
        },
        actions: [
          {
            title: 'Open KickerApp',
            type: 'openWatchApp',
            launchCode: 0
          }
        ]
      }

      Rails.logger.info "Pin ID: match-#{match.id} #{payload[:status]} pin: #{pin}"

      if payload[:status] == :created
        createNotification =
          pins.create(pin.merge(
                        id: "match-#{match.id}",
                        createNotification: {
                          layout: {
                            type: 'genericNotification',
                            title: "New Match in #{match.league.name}",
                            tinyIcon: 'system://images/NOTIFICATION_FLAG',
                            body: "#{match.winner_team.name} played against #{match.loser_team.name}. Result was: #{match.score}"
                          }
                        }
          ))
      else
        pins.update("match-#{match.id}", pin)
      end
    end
  end
end
