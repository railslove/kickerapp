json.array! @leagues.where('matches_count > 1').reorder(name: :asc) do |league|
  json.name league.name
  json.slug league.slug
end
