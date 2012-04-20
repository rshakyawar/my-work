class SchwagShot < ActiveRecord::Base
  belongs_to :versus
  belongs_to :member
  
  def self.verify_shot(versus, shot_number)
    magic_numbers = self.twenty_numbers(versus.schwag_magic_numbers)
    return true if magic_numbers.include?(shot_number + "--")
    return false
  end
  
  def self.validate_shot_number(versus, shot_number)
    return false if shot_number.to_i > 45
    self.verify_shot(versus, shot_number)
  end
  
  def self.shot_result(versus, member, shot_number)
    return update_winner_schwag_db(versus, member, shot_number) if self.validate_shot_number(versus, shot_number)
    return update_looser_schwag_db(versus, member, shot_number)
  end
  
  def self.twenty_numbers magic_numbers
    return magic_numbers.split("@@")
    return_arr = []
    magic_numbers.split("@@").each do |number|
      return_arr.push(number.delete("--"))
    end
    return return_arr
  end
  
  def self.update_winner_schwag_db(versus, member,  shot_number)
    if versus.update_schwag_magic_number(shot_number)
      versus.schwag_winners.create(:member_id=>member.id,:magic_number=>shot_number)
      versus.success_schwag_shot(member, shot_number)
      return "win"
    else
      self.update_looser_schwag_db(versus, member, shot_number)
    end
  end
  
  def self.update_looser_schwag_db(versus, member, shot_number)
    versus.failure_schwag_shot(member, shot_number)
    return "loose"
  end
  
  def ready_to_next
    return false if shot_count > 2
    return ready_to_next_question
  end
  
  def ready_to_next_true
    self.ready_to_next_question = true
    self.fb_twit_token = nil 
    self.save
  end
  
end
