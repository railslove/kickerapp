json.array! @leagues.where('matches_count > 1').where('updated_at > ?', 4.month.ago).reorder(name: :asc) do |league|
  json.name league.name
  json.slug league.slug
end
