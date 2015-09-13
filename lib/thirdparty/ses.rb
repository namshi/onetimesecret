require 'aws-sdk'

class Ses
  attr_accessor :aws_access_key, :aws_access_secret, :region, :from
  def initialize aws_access_key, aws_access_secret, region, from
    @aws_access_key, @aws_access_secret, @region, @from = aws_access_key, aws_access_secret, region, from
  end
  def send to, subject, text

    ses = Aws::SES::Client.new(
      access_key_id: aws_access_key,
      secret_access_key: aws_access_secret,
      region: region
    )
    ses.send_email({
      source: from,
      destination: {
        to_addresses: [to]
      },
      message: {
        subject: {
          data: subject
        },
        body: {
          text: {
            data: text
          }
        }
      }
    })
  end
end
