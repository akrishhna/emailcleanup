class Email < ActiveRecord::Base
  has_attached_file :file
  has_many :emailstatuses, :dependent => :destroy
  
  validates_attachment_presence :file, :message => "can\'t be empty"
  validates_attachment_content_type :file, :content_type => ['application/txt','application/cvs','text/plain', 'application/xls', 'application/rtf']
  
  def self.extract_emails_to_array(txt)
      reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
      txt.scan(reg).uniq
  end
  
end
