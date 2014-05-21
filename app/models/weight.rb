class Weight < ActiveRecord::Base
	before_validation :init_value

	validates_presence_of :weight_date
	validates_presence_of :weight_time
	validates_presence_of :weight

  scope :most_recent_by_date, -> { order('weight_date desc') }
  scope :in_the_last_week, -> { where( :weight_date => 7.days.ago..Date.today) }
  scope :in_the_last_thirty_days, -> { where( :weight_date => 30.days.ago..Date.today) }
  scope :in_the_last_ninety_days, -> { where( :weight_date => 90.days.ago..Date.today) }
  scope :in_the_last_year, -> { where( :weight_date => 365.days.ago..Date.today) }

  def weight_change
		weight.each do |a,b|
			(b.to_f - a.to_f)/a.to_f * 100.0
		end
	end

  def init_value
    self.weight_date ||= Date.today.strftime('%m/%d/%Y')
    self.weight_time ||= Time.now.strftime('%I:%M %Z')
  end

end