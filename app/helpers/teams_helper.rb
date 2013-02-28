module TeamsHelper
  def balance_bar(matches, wins, loses)
    content_tag(:div, :class => "progress") do
      raw("<div class=\"bar bar-success\", style=\"width: #{(wins/matches.to_f)*100}%;\"></div>
           <div class=\"bar bar-danger\", style=\"width: #{(loses/matches.to_f)*100}%;\"></div>")
    end
  end
end
