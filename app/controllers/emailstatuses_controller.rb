class EmailstatusesController < ApplicationController
def index
@emailstatuses = Emailstatus.all
respond_to do |format|
      format.html
      format.xml { render :xml => @emailstatuses }
      format.xls { send_data @emailstatuses.to_xls }
end
end
end
