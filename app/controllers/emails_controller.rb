class EmailsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new]

  def new
    @email = Email.new
  end
  def index
    @emails = Email.all(:conditions => ['user_id = ?', current_user.id])  
  end
  def create
    @email = Email.new(params[:email])
   @email.user_id = current_user.id
    file_data = @email.file
     #puts file_data
    respond_to do |format|
    if @email.save
      if file_data.respond_to?(:path)
               input = IO.readlines(file_data.path)
               arr = Email.extract_emails_to_array(input.join(" ")).sort
               #puts arr 
               arr.each do |i|
               @arr = i
               emailid = @arr
               puts emailid
               @emailstat = Emailstatus.verify_email(emailid)
                if @emailstat 
               Emailstatus.create(:emailid => @arr, :status => "valid", :email_id => @email.id)
               else
                Emailstatus.create(:emailid => @arr, :status => "invalid", :email_id => @email.id)    
                end
               end
      end
      flash[:notice]= 'file saved succusfully'
      format.html {redirect_to(@email)}
      
      
    
    else
      format.html {render :action => "new"}
    end
  end
  end
  def show
         @email = Email.find(params[:id])
         @emailstatuses =Emailstatus.paging(params[:page],params[:id])
         @emailstatuses.each do |i|
           puts i.emailid
         end

  end
  def valid
    @email = Email.find(params[:id])
    puts @email.id
        filtertype = "valid"
        @emailstatuses = Emailstatus.valid(params[:page], filtertype, params[:id])
        @emailstatuses.each do |i|
          $id = i.email_id
        end 
         $value = $id
        @validemailstatuses = Emailstatus.all(:conditions => ['status = ? and email_id  = ?',"valid", $value])
        
        
  end
  def invalid
     @email = Email.find(params[:id])
      puts @email.id
    filtertype = "invalid"
    @emailstatuses = Emailstatus.invalid(params[:page], filtertype, params[:id])
    
    @emailstatuses.each do |i|
      $id = i.email_id
    end 
     $value = $id
     puts $value
    @invalidemailstatuses = Emailstatus.all(:conditions => ['status = ? and email_id  = ?',"invalid", $value])
  end
  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    flash[:notice] = "File deleted successfully"
    respond_to do |format|
      format.html { redirect_to(emails_url) }
      format.xml  { head :ok }
    end
  end
  
end

