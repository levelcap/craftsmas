class Draw
  def draw
    users = []
    CSV.foreach("craftsmas.csv") do |row|
      user = {
        name: row[1].strip,
        email: row[2].strip,
        questions: [{
            question: row[3],
            answer: row[4],
          },
          {
            question: row[5],
            answer: row[6],
          },
          {
            question: row[7],
            answer: row[8],
          },
        ],
        other: row[9],
      }
      pp user
      users << user
    end
  end
end
