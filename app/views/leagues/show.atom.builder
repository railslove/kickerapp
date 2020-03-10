# frozen_string_literal: true

atom_feed do |feed|
  feed.title 'Railslove Kicker Matches'
  feed.updated @matches.first.present? ? @matches.first.date : Date.today

  @matches.each do |match|
    feed.entry match do |entry|
      entry.title match.title
      entry.content match.content
      entry.author do |author|
        author.name @matches.first.league.name
      end
      entry.updated match.date
    end
  end
end
