#!/usr/bin/env ruby

require 'twilio-ruby'
require 'rubygems'
require 'json'

file = open("config.json")
json = file.read
parsed = JSON.parse(json)

TWILIO_ACCOUNT_SID = parsed["config"]["TWILIO_ACCOUNT_SID"]
TWILIO_AUTH_TOKEN = parsed["config"]["TWILIO_AUTH_TOKEN"]

@twilio = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

from_number = parsed["config"]["TWILIO_ACCOUNT_NUMBER"]
to_number = parsed["config"]["YOUR_NUMBER"]

pickuplines = []
File.read("pickuplines.txt").each_line do |line|
  pickuplines << line.chop
end

line = pickuplines.sample

@twilio.messages.create(
  from: from_number, to: to_number, body: "#{line}"
)

puts "Message sent at: #{Time.now}"
