class Draw
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
      # pp user
      users << user
    end

    match_list = Draw::match_users(users)
    DrawMailer.with(match: match_list.first, users:).draw_email.deliver_now
    # match_list.each do |match|
    #   UserMailer.new.draw_email(match:, users:)
    # end
  end

  private

  def self.match_users(users)
    user_emails = users.map do |user|
      user[:email]
    end
    already_matched_emails = []
    match_list = []

    user_emails.each do |user_email|
      matched_email = Draw::potential_match_emails(emails: user_emails, already_matched_emails:, own_email: user_email).sample
      already_matched_emails << matched_email
      match_list << { gifter: user_email, giftee: matched_email}
    end

    return match_list
  end

  private

  def self.potential_match_emails(emails:, already_matched_emails: [], own_email:)
    excluded = Draw::user_specific_exclude(already_matched_emails:, own_email:)
    (emails - excluded).uniq
  end

  def self.user_specific_exclude(already_matched_emails: [], own_email:, excluded_emails:[])
    user_specific = already_matched_emails.clone
    (user_specific << own_email).uniq
  end
end
