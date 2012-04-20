require 'net/http'
require 'net/https'
require 'open-uri'

class Icontact

  ICONTACT_URL = "https://app.icontact.com/icp/a/#{APPLICATION_CONFIG.icontact.accountid}/c/#{APPLICATION_CONFIG.icontact.clientfolderid}"
  ICONTACT_BASE_URL = "https://app.icontact.com/icp/a/"
  def initialize(header_content)
     @headers = {
          'Accept' => header_content["accept_type"],
          'Content-Type' => header_content["content_type"],
          'Api-Version' => header_content["api_version"],
          'Api-AppId' => header_content["api_app_id"],
          'Api-Username' => header_content["api_user_name"],
          'API-Password' => header_content["api_password"]
      }
  end

  def get_account_id
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_account_id.log")
    url = URI.parse(ICONTACT_BASE_URL)
    sock = get_sock(url)
    resp , get_data =  sock.get(url.request_uri , @headers)
    contact_hash = ActiveSupport::JSON.decode(resp.body)
    logger.info " "
    logger.info "new contact is created : #{contact_hash} "
    logger.info " ============================= "
    return contact_hash
  end

  def get_client_folder_id
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_client_folder_id.log")
    url = URI.parse("#{ICONTACT_BASE_URL}#{APPLICATION_CONFIG.icontact.accountid}/c")
    sock = get_sock(url)
    resp , get_data =  sock.get(url.request_uri , @headers)
    contact_hash = ActiveSupport::JSON.decode(resp.body)
    logger.info " "
    logger.info "new contact is created : #{contact_hash} "
    logger.info " ============================= "
    return contact_hash
  end

  def get_list
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_list_id.log")
    url = URI.parse("https://app.icontact.com/icp/a/#{APPLICATION_CONFIG.icontact.accountid}/c/#{APPLICATION_CONFIG.clientfolderid}/lists/#{APPLICATION_CONFIG.icontact.subscriber_list_id}")
    sock = get_sock(url)
    resp , get_data =  sock.get(url.request_uri , @headers)
    contact_hash = ActiveSupport::JSON.decode(resp.body)
    logger.info " "
    logger.info "new contact is created : #{contact_hash} "
    logger.info " ============================= "
    return contact_hash
  end
  
  def create_icontact( contact_object)
    url = URI.parse("#{ICONTACT_URL}/contacts")
    sock = get_sock(url)
    resp , get_data =  sock.post(url.path, contact_object , @headers)
    return resp
  end

  def self.get_contact_obj (email)
  return {"contacts"=> {"email"=>email , "firstName"=>"" , "lastName"=>"", "phone"=>"", "street"=>"", "city"=>"", "state"=>"", "postalCode"=>"", "createDate"=>"", "username" => "", "password" => ""}}.to_json
  end

  def add_contact_tolist(contact_id,list_id)
    url = URI.parse("#{ICONTACT_URL}/subscriptions")
    subscription_obj = {"subscriptions"=> {"contactId" => contact_id , "listId" => list_id , "status"=>"normal" }}.to_json
    sock = get_sock(url)
    resp , get_data =  sock.post(url.path, subscription_obj , @headers)
    return resp
  end

  def update_contact_in_icontact(contact_id,contact_obj)
    url = URI.parse("#{ICONTACT_URL}/contacts/#{contact_id}")
    sock = get_sock(url)
    resp , get_data = sock.put(url.request_uri,contact_obj,@headers)
    return decode_json_into_hash(resp.body)
  end

  def self.add_contact_from_memberobj(user,is_new_user)
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_list.log")
    logger.info " new contact #{user.email} "
    icontact = self.new(APPLICATION_CONFIG.icontact.header.to_hash)
    response_icontact = icontact.create_icontact(self.get_contact_obj(user.email))
    contact_hash = ActiveSupport::JSON.decode(response_icontact.body)
    #logger.info " new contact is created : #{response_icontact.code} "
    logger.info " new contact id is  #{contact_hash["contacts"][0]["contactId"]} "
    icontact.add_contact_tolist(contact_hash["contacts"][0]["contactId"],APPLICATION_CONFIG.icontact.subscriber_list_id)
    logger.info " new contact is created : #{user.email} "
    logger.info " ============================= "
  end
  
  def self.add_guest_user(user,is_new_user)
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_guest_user_list.log")
    logger.info " new contact #{user.email} "
    icontact = self.new(APPLICATION_CONFIG.icontact.header.to_hash)
    response_icontact = icontact.create_icontact(self.get_contact_obj(user.email))
    contact_hash = ActiveSupport::JSON.decode(response_icontact.body)
    #logger.info " new contact is created : #{response_icontact.code} "
    logger.info " new contact id is  #{contact_hash["contacts"][0]["contactId"]} "
    icontact.add_contact_tolist(contact_hash["contacts"][0]["contactId"],APPLICATION_CONFIG.icontact.guest_user_id)
    logger.info " new contact is created : #{user.email} "
    logger.info " ============================= "
  end
  
  
  def self.get_contact_member_obj (member)
    return {"contacts"=> {"email"=>member.email , "firstName"=>member.first_name , "lastName"=>member.last_name, "phone"=>"", "street"=>member.my_mail_goes_to, "city"=>member.city, "state"=>member.state, "postalCode"=>member.zip, "createDate"=>member.created_at, "username" => member.stash_name, "password" => member.stash_word}}.to_json
  end
  
  def self.get_update_contact_member_obj (member)
    return {"email"=>member.email , "firstName"=>member.first_name , "lastName"=>member.last_name, "phone"=>"", "street"=>member.my_mail_goes_to, "city"=>member.city, "state"=>member.state, "postalCode"=>member.zip, "createDate"=>member.created_at, "username" => member.stash_name, "password" => member.stash_word}.to_json
  end
  
  def self.add_contact_from_tsb_member(user,is_new_user)
    logger=Logger.new("#{RAILS_ROOT}/log/icontact_member_list.log")
    logger.info " new contact #{user.email} "
    icontact = self.new(APPLICATION_CONFIG.icontact.header.to_hash)
    contact_hash = icontact.find_contact_by_email(user.email)
    if contact_hash["contacts"].blank?
      response_icontact = icontact.create_icontact(self.get_contact_member_obj(user))
      contact_hash2 = ActiveSupport::JSON.decode(response_icontact.body)
      #logger.info " new contact is created : #{response_icontact.code} "
      unless contact_hash2["contacts"].blank? 
        logger.info " new contact id is  #{contact_hash2["contacts"][0]["contactId"]} "
        icontact.add_contact_tolist(contact_hash2["contacts"][0]["contactId"],APPLICATION_CONFIG.icontact.member_list_id)
        logger.info " new contact is created : #{user.email} "
        logger.info " ============================= "
      else
        logger3 = Logger.new("#{RAILS_ROOT}/log/icontact_error_in_create_member_list.log")
        logger.info " error to create this contact : #{user.email} "
        logger.info " ============================= "
      end
    else
      logger2=Logger.new("#{RAILS_ROOT}/log/icontact_update_member_list.log")
      response_icontact = icontact.update_contact_in_icontact(contact_hash["contacts"][0]["contactId"],self.get_update_contact_member_obj(user))
      subscription_info = icontact.find_subscription_info(contact_hash["contacts"][0]["contactId"])
      logger2.info " response : #{subscription_info} "
      unless subscription_info["subscriptions"][0]["listId"].to_s == APPLICATION_CONFIG.icontact.member_list_id.to_s
        icontact.move_contact_to_new_list(subscription_info["subscriptions"][0]["subscriptionId"],APPLICATION_CONFIG.icontact.member_list_id)
        logger2.info " contact has been moved into member list :  #{user.email}"
      end
      logger2.info " contact has been updated :  id(#{user.id})/email(#{user.email})"
      logger2.info " ============================= "
    end
  end

  def find_contact_by_email(user_email)
    url = URI.parse("#{ICONTACT_URL}/contacts?email=#{user_email}")
    sock = get_sock(url)
    resp , get_data = sock.get(url.request_uri,@headers)
    return decode_json_into_hash(resp.body)
  end
  
  def find_subscription_info(contact_id)
    url = URI.parse("#{ICONTACT_URL}/subscriptions?contactId=#{contact_id}")
    sock = get_sock(url)
    resp , get_data = sock.get(url.request_uri,@headers)
    return decode_json_into_hash(resp.body)
  end
  
  def move_contact_to_new_list(subscription_id,new_list_id)
    url = URI.parse("#{ICONTACT_URL}/subscriptions/#{subscription_id}")
    subscription_obj = {"listId" => "#{new_list_id}"}.to_json
    sock = get_sock(url)
    resp , get_data = sock.put(url.request_uri,subscription_obj,@headers)
    return decode_json_into_hash(resp.body)
  end

private

  def get_sock(url)
    sock = Net::HTTP.new(url.host, url.port)
    sock.use_ssl = true
    return sock
  end

  def decode_json_into_hash(resp)
    return ActiveSupport::JSON.decode(resp)
  end
end
