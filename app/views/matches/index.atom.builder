atom_feed do |feed|
  feed.title "Railslove Kicker Matches"
  feed.updated @matches.first.date

  @matches.each do |match|
    feed.entry match do |entry|
      entry.title match.title
      entry.content match.content
      entry.author do |author|
        author.name 'Railslove Kicker'
      end
    end
  end
end
