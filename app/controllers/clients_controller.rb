class ClientsController < ApplicationController
  
  Twilio_sid = 'ACee185e4fdf1ff6dac321d90841f23f25'
  Twilio_token = '6fcd44041f413e6db99c8513673e0a5a'
  Twilio_phone_number = "6479311279"
  BASE_URL= 'localhost:3000/clients'
  def sms
    @client = Client.find(params[:id])
    
    @twilio_client = Twilio::REST::Client.new Twilio_sid, Twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{Twilio_phone_number}",
      :to => @client.phone,
      :body => @client.message
    )
  end

  def makecall
    @client = Client.find(params[:id])
 
    begin
      @twilio_client = Twilio::REST::Client.new Twilio_sid, Twilio_token
      @twilio_client.account.calls.create(
      :from => "+1#{Twilio_phone_number}",
      :to => @client.phone,
      :url => speak_client_url(@client)
        )
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end
 
  end
# TwiML response that reads the reminder to the caller and presents a
# short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def speak
    response = Twilio::TwiML::Response.new do |r|
  r.Say 'hello there', :voice => 'woman'
  end
  @xml=response.text
end



  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end

  end

  
  
  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
end
