class Appointment < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true

  after_create :reminder

  @@REMINDER_TIME = 30.minutes # minutes before appointment

  # Notify our appointment attendee X minutes before the appointment time
  def reminder
    @twilio_number = '+17206136526'
    @client = Twilio::REST::Client.new 'AC1138789c1d36063211f311d9d1f3480a', '86bfb412a7d74d879d86a89ecafd5896'
    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    reminder = "Hi #{self.name}. Purva has invited you to an event occuring on #{time_str}. To RSVP to this event, please reply YES to this message"
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone_number,
      :body => reminder,
    )
    puts message.to
  end
end