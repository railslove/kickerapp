# frozen_string_literal: true

class CommentGenerator
  def self.random(winner_goals, loser_goals, crawling = false, add_quotation = false)
    difference = (loser_goals - winner_goals).abs
    content = ''
    case difference
    when 1..2
      content += 'Das war knapp! '
    when 3
      content += 'Ganz souveräne Vorstellung. '
    when 4
      content += 'Eindeutige Sache. '
    when 5
      content += 'Klare Angelegenheit. '
    when 6
      content += 'Glasklare Angelegenheit. '
    end
    content += "#{winner_goals}:#{loser_goals}. "
    content += ' Es wurde gekrabbelt! ' if crawling.present?
    content += quotation if add_quotation
    content
  end

  private

  def self.quotation
    quotations = [
      'Olaf Thon: Wir lassen uns nicht nervös machen, und das geben wir auch nicht zu!',
      'Lothar Matthäus: Ich hab gleich gemerkt, das ist ein Druckschmerz, wenn man drauf druckt.',
      'Ingo Anderbrügge: Das Tor gehort zu 70 % mir und zu 40 % dem Wilmots.',
      'Richard Golz: Ich habe nie an unserer Chancenlosigkeit gezweifelt.',
      'Toni Polster: Für mich gibt es nur "entweder-oder". Also entweder voll oder ganz!',
      'Rudi Völler: Zu 50 Prozent stehen wir im Viertelfinale, aber die halbe Miete ist das noch lange nicht!',
      'Fritz Walter jun.: Der Jürgen Klinsmann und ich, wir sind ein gutes Trio. (etwas spater dann) Ich meinte: ein Quartett.',
      'Roland Wohlfahrt: Zwei Chancen, ein Tor - das nenne ich hundertprozentige Chancenauswertung.',
      'Andreas Möller: Ich hatte vom Feeling her ein gutes Gefühl.',
      'Thomas Häßler: Wir wollten kein Gegentor kassieren. Das hat auch bis zum Gegentor ganz gut geklappt.',
      'Stefan Effenberg: Die Situation ist aussichtslos, aber nicht kritisch.',
      'Berti Vogts: Ich glaube, daß der Tabellenerste jederzeit den Spitzenreiter schlagen kann.',
      'Hans Krankl: Wir müssen gewinnen, alles andere ist primar.',
      'Theo Zwanziger: Die Breite an der Spitze ist dichter geworden.',
      'Bryan Robson: Würden wir jede Woche so spielen, wären unsere Leistungen nicht so schwankend.',
      'Berti Vogts: Wir haben ein Abstimmungsproblem – das müssen wir automatisieren.'
    ]
    quotations.sample
  end
end
