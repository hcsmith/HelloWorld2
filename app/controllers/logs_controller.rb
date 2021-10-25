
class LogsController < ApplicationController

  def index
     puts "Hello World Logging Rails!"
  end

  def display

     client = Aws::Lambda::Client.new();

     resp = client.invoke({
       function_name: "ParseCloudWatch", # required
       invocation_type: "RequestResponse", # accepts Event, RequestResponse, DryRun   # use Synchronous
       log_type: "None", # accepts None, Tail
       client_context: Base64.encode64('{ "zzz":"9000"}'),  # Sample context, unused
       payload: '{ "p1": "Sample Input"}',
  #     qualifier: "Qualifier",
     })

     @data = ActiveSupport::JSON.decode(resp.payload.string)

     status = @data['statusCode']

     if (status != 200)
        render html: "Lambda invocation Error: "+status.to_s
     else
        render inline: '<pre><code>'+@data['body']+'</code></pre>'
     end

  end

end
