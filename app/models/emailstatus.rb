class Emailstatus < ActiveRecord::Base
  belongs_to :email
  

  def self.paging(page, id)
        paginate :per_page => 5, :page => page,
                   :conditions => ['email_id  = ?', id]
                   
  end
  def self.valid(page, filtertype, id)
    paginate :per_page => 5, :page => page,
               :conditions => ['status = ? and email_id  = ?', filtertype, id]
  end 
  def self.invalid(page, filtertype, id)
    paginate :per_page => 5, :page => page,
               :conditions => ['status = ? and email_id  = ?', filtertype, id]
  end

    
  require 'resolv'

      # def self.validate_email_domain(emailid)
      #             domain = emailid.match(/\@(.+)/)[1]
      #             Resolv::DNS.open do |dns|
      #                 @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      #             end
      #             @mx.size > 0 ? true : false
      #             
      #       end
      
       def self.verify_email(emailid)
         stringdomain = emailid.match(/\@(.+)/)[1]
          domain = 'nslookup -query=mx'<<' '<<  "#{stringdomain}"
          rcptto = "RCPT TO:<"<< "#{emailid}"<<'>'
          str = `#{domain}`.split("\n").select{|line|line=~/mail exchanger = /}.map{|line|((host=line.split(" ")[-2])[-1,1]==".")?host[0..-2]:host.to_i}

          a = str.min.to_s

          actualhost = `#{domain}`.split("\n").select{|line|line=~/mail exchanger = #{a}/}.map{|line|((host=line.split(" ")[-1])[-1,1]==".")?host[0..-2]:host}
          puts actualhost
          require 'socket'
          t = TCPSocket.new("#{actualhost}", 25)
          puts t.gets
          t.puts 'HELO Welcome from Ruby'
          puts t.gets
          t.puts 'MAIL FROM:<ashwini@unedollar.com>'
          puts t.gets
          t.puts "#{rcptto}"
          status = t.gets
          puts status
          if status.match("OK")
            puts "valid"
              return status
          end
          # t.puts 'DATA'
          # puts t.gets
          # t.puts 'Test Email from Ruby'
          # t.puts "\r\n.\r\n"
          # puts t.gets
          t.puts 'QUIT'
          puts t.gets
          t.close
           
        end
      
      # unless emailid.blank?
      #           unless emailid =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
      #               errors.add(:emailid, "Your email address does not appear to be valid")
      #           else
      #               errors.add(:emailid, "Your email domain name appears to be incorrect") unless validate_email_domain(email)
      #           end
      #       end
end
