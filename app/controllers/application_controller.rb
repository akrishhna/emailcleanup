class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper_method :authorize_user?
  #   protected
  #   def authorize_user
  #     @emails = Email.all(:conditions => ['user_id = ?', current_user.id])
  #     @emails.each do |i|
  #       @userid=i.user_id
  #     end
  #     unless current_user.id == @userid
  #       flash[:notice] = "Unauthorized access"
  #       redirect_to :controller => 'emails', :action => 'new'
  #     end
  #   end
end
