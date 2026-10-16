class Draw
  EXCLUSIONS = {
    "bchalmer@gmail.com" => ["alissazimmer@gmail.com","cohen.davids@gmail.com"],
    "lcastanon@gmail.com" => ["benlaverriere@gmail.com"],
    "Gcastanon@gmail.com" => ["anna.gartsman@gmail.com","anna.gartsman+ezra@gmail.com"],
    "sixdgreesaway@gmail.com" => ["joey.peter.sbarro@gmail.com"],
    "alissazimmer@gmail.com" => ["cohen.davids@gmail.com","bchalmer@gmail.com","pmayer.tech@gmail.com"],
    "cohen.davids@gmail.com" => ["alissazimmer@gmail.com","bchalmer@gmail.com","anna.gartsman@gmail.com"],
    "joey.peter.sbarro@gmail.com" => ["sixdgreesaway@gmail.com"],
    "scott.istvan@gmail.com" => ["greg@gregjb.com"],
    "anna.gartsman@gmail.com" => ["anna.gartsman+ezra@gmail.com","gcastanon@gmail.com","sixdgreesaway@gmail.com"],
    "anna.gartsman+ezra@gmail.com" => ["gcastanon@gmail.com","anna.gartsman@gmail.com","joey.peter.sbarro@gmail.com"],
    "paulrgels@gmail.com" => ["greg@gregjb.com"],
    "greg@gregjb.com" => ["paulrgels@gmail.com","alissazimmer@gmail.com"],
    "pmayer.tech@gmail.com" => ["pmayer.tech+anthony@gmail.com","ernstjess@gmail.com","bchalmer@gmail.com"],
    "pmayer.tech+anthony@gmail.com" => ["pmayer.tech@gmail.com","ernstjess@gmail.com"],
    "ernstjess@gmail.com" => ["pmayer.tech+anthony@gmail.com","pmayer.tech@gmail.com","anna.gartsman+ezra@gmail.com"],
  }

  def self.exclude
    csv_contents = CSV.read('exclusions.csv')
    csv_contents.shift
    csv_contents.each do |row|
      ex = row[1].split("|")
      ex = ex.map do |e|
        "'#{e.strip}'"
      end
      pp "'#{row[0]}' => [#{ex.join(",")}],"
    end
  end

  def self.draw
    users = []
    csv_contents = CSV.read('craftsmas.csv')
    csv_contents.shift
    csv_contents.each do |row|
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
      users << user
    end

    match_list = Draw::match_users(users)
    match_list.each do |match|
      DrawMailer.with(match:, users:).draw_email.deliver_now
    end
  end

  private

  def self.match_users(users)
    user_emails = users.map do |user|
      user[:email]
    end
    match_list = []
    try_draw = true

    while(try_draw)
      try_draw = false
      already_matched_emails = []
      match_list = []
      user_emails.each do |user_email|
        matched_email = Draw::potential_match_emails(emails: user_emails, already_matched_emails:, own_email: user_email).sample
        if matched_email.nil?
          try_draw = true
        end
        already_matched_emails << matched_email
        match_list << { gifter: user_email, giftee: matched_email}
      end
    end

    return match_list
  end

  private

  def self.potential_match_emails(emails:, already_matched_emails: [], own_email:)
    excluded = Draw::user_specific_exclude(already_matched_emails:, own_email:)
    (emails - excluded).uniq
  end

  def self.user_specific_exclude(already_matched_emails: [], own_email:, excluded_emails:[])
    exclusions = EXCLUSIONS[own_email]

    user_specific = already_matched_emails.clone
    (user_specific << exclusions << own_email).flatten.uniq
  end
end
