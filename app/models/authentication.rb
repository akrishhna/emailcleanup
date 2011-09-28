class Authentication < ActiveRecord::Base
  #attr_accessible :user_id, :provider, :uid
  belongs_to :user
  
 
  #   
  #   def apply_trusted_services(omniauth) 
  #       user_info = omniauth['user_info']
  #       if omniauth['extra'] && omniauth['extra']['user_hash']
  #         user_info.merge!(omniauth['extra']['user_hash'])
  #       end 
  #       if self.name.blank?
  #         self.name   = user_info['name']   unless user_info['name'].blank?
  #         self.name ||= user_info['nickname'] unless user_info['nickname'].blank?
  #         self.name ||= (user_info['first_name']+" "+user_info['last_name']) unless \
  #           user_info['first_name'].blank? || user_info['last_name'].blank?
  #       end  
  #       if self.email.blank?
  #         self.email = user_info['email'] unless user_info['email'].blank?
  #       end 
  #       self.password, self.password_confirmation = String::RandomString(16)  
  #       self.confirmed_at, self.confirmation_sent_at = Time.now 
  #     end
end
