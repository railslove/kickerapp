# frozen_string_literal: true

json.array! @leagues.where('matches_count > 1').includes(:matches).reorder(name: :asc).select { |l| l.matches.first.date > 2.month.ago } do |league|
  json.name league.name
  json.slug league.slug
  json.matches_count league.matches_count
end
